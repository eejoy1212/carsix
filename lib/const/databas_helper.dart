import 'dart:convert';

import 'package:carsix/models/custom_mode_model.dart';
import 'package:carsix/models/lighting_model.dart';
import 'package:carsix/models/music_mode_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'carsix_12.db');

    return await openDatabase(
      databasePath,
      version: 12, // 버전 업데이트
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE lighting_modes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          leftCenterColor INTEGER,
          leftCenterBright REAL,
          leftCenterFavorites TEXT,
          rightCenterColor INTEGER,
          rightCenterBright REAL,
          rightCenterFavorites TEXT,
          leftFirstDriverColor INTEGER,
          leftFirstDriverBright REAL,
          leftFirstDriverFavorites TEXT,
          rightFirstPassengerColor INTEGER,
          rightFirstPassengerBright REAL,
          rightFirstPassengerFavorites TEXT,
          leftSecondDriverColor INTEGER,
          leftSecondDriverBright REAL,
          leftSecondDriverFavorites TEXT,
          rightSecondPassengerColor INTEGER,
          rightSecondPassengerBright REAL,
          rightSecondPassengerFavorites TEXT
        )
      ''');
        await db.execute('''
        CREATE TABLE custom_modes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          apply INTEGER,
          selectedBgCustomColor INTEGER,
          customBgColors TEXT,
          selectedSel1CustomColor INTEGER,
          customSel1Colors TEXT,
          selectedSel2CustomColor INTEGER,
          customSel2Colors TEXT,
          bgBright REAL,
          bgVelocity REAL,
          sel1Bright REAL,
          sel1Velocity REAL,
          sel2Bright REAL,
          sel2Velocity REAL
        )
      ''');

        await db.execute('''
        CREATE TABLE apply_mode (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          currentApplyMode INTEGER
        )
      ''');

        // active_mode 테이블 생성
        await db.execute('''
          CREATE TABLE active_mode (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            welcome1 TEXT,
            welcome1Favorites TEXT,
            welcome2 TEXT,
            welcome2Favorites TEXT,
            weather TEXT,
            goodbye1 TEXT,
            goodbye1Favorites TEXT,
            goodbye2 TEXT,
            goodbye2Favorites TEXT,
            goodbye3 TEXT,
            goodbye3Favorites TEXT,
            now_selected_ceremony TEXT -- 새로 추가된 필드
          )
        ''');

        // single_color 테이블 생성
        await db.execute('''
          CREATE TABLE single_color (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            selectedColor TEXT,
            favoriteColors TEXT
          )
        ''');
        //뮤직모드 테이블 생성
        await db.execute('''
        CREATE TABLE music_modes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          selectedMusicColor INTEGER,
          musicColors TEXT,
          musicBright REAL,
          apply INTEGER
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 9) {
          await db.execute(
              'ALTER TABLE active_mode ADD COLUMN now_selected_ceremony TEXT');
        }
        // single_color 테이블 추가 (이미 존재하지 않을 경우)
        if (oldVersion < 9) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS single_color (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              selectedColor TEXT,
              favoriteColors TEXT
            )
          ''');
        }
        if (oldVersion < 12) {
          await db.execute('''
          CREATE TABLE IF NOT EXISTS lighting_modes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            leftCenterColor INTEGER,
            leftCenterBright REAL,
            leftCenterFavorites TEXT,
            rightCenterColor INTEGER,
            rightCenterBright REAL,
            rightCenterFavorites TEXT,
            leftFirstDriverColor INTEGER,
            leftFirstDriverBright REAL,
            leftFirstDriverFavorites TEXT,
            rightFirstPassengerColor INTEGER,
            rightFirstPassengerBright REAL,
            rightFirstPassengerFavorites TEXT,
            leftSecondDriverColor INTEGER,
            leftSecondDriverBright REAL,
            leftSecondDriverFavorites TEXT,
            rightSecondPassengerColor INTEGER,
            rightSecondPassengerBright REAL,
            rightSecondPassengerFavorites TEXT
          )
        ''');
        }
      },
    );
  }

//인덱스가 뮤직모드
  Future<void> saveMusicModes(List<Rx<MusicMode>> musicModeModels) async {
    final db = await database;
    await db.delete('music_modes'); // 기존 데이터 삭제

    for (var rxMusicMode in musicModeModels) {
      final musicMode = rxMusicMode.value;
      await db.insert(
        'music_modes',
        {
          'selectedMusicColor': musicMode.selectedMusicColor.value,
          'musicColors': jsonEncode(
              musicMode.musicColors.map((color) => color.value).toList()),
          'musicBright': musicMode.musicBright,
          'apply': musicMode.apply ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Rx<MusicMode>>> getMusicModes() async {
    final db = await database;
    final result = await db.query('music_modes');

    return result.map((row) {
      return Rx(
        MusicMode(
          selectedMusicColor: Color(row['selectedMusicColor'] as int),
          musicColors:
              (jsonDecode(row['musicColors'] as String) as List<dynamic>)
                  .map((colorValue) => Color(colorValue))
                  .toList(),
          musicBright: row['musicBright'] as double,
          apply: (row['apply'] as int) == 1,
        ),
      );
    }).toList();
  }

  // single_color 저장
  Future<void> saveSingleColor({
    required String selectedColor,
    required List<String> favoriteColors,
  }) async {
    final db = await database;

    await db.delete('single_color'); // 이전 데이터를 삭제하고 새로 저장
    await db.insert(
      'single_color',
      {
        'selectedColor': selectedColor,
        'favoriteColors': jsonEncode(favoriteColors),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // single_color 조회
  Future<Map<String, dynamic>?> getSingleColor() async {
    final db = await database;

    final result = await db.query('single_color', limit: 1);

    if (result.isNotEmpty) {
      final row = result.first;

      return {
        'selectedColor': row['selectedColor'] as String,
        'favoriteColors':
            jsonDecode(row['favoriteColors'] as String) as List<dynamic>,
      };
    }
    return null;
  }

  // 커스텀 모드 저장
  Future<void> saveCustomMode({
    required String mode,
    required String bgFavorite,
    required int bgNow,
    required String sel1Favorite,
    required int sel1Now,
    required String sel2Favorite,
    required int sel2Now,
  }) async {
    final db = await database;

    await db.insert(
      'custom_modes',
      {
        'mode': mode,
        'bgFavorite': bgFavorite,
        'bgNow': bgNow,
        'sel1Favorite': sel1Favorite,
        'sel1Now': sel1Now,
        'sel2Favorite': sel2Favorite,
        'sel2Now': sel2Now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 커스텀 모드 조회
  Future<Map<String, dynamic>?> getCustomMode(String mode) async {
    final db = await database;
    final result =
        await db.query('custom_modes', where: 'mode = ?', whereArgs: [mode]);

    print("커스텀 모드 조회 결과 >>> $result");

    return result.isNotEmpty ? result.first : null;
  }

  // 커스텀 모드 타입과 모드에 맞는 조회
  Future<Map<String, dynamic>?> getCustomTypeColor({
    required String mode,
    required String bgFavorite,
  }) async {
    final db = await database;

    final result = await db.query(
      'custom_modes',
      where: 'mode = ? AND bgFavorite = ?',
      whereArgs: [mode, bgFavorite],
    );

    print("커스텀 모드 조회 결과 >>> $result");

    return result.isNotEmpty ? result.first : null;
  }

  // currentApplyMode 저장
  Future<void> saveCurrentApplyMode(int currentApplyMode) async {
    final db = await database;

    // 기존 데이터를 삭제하고 새로운 데이터를 저장
    await db.delete('apply_mode');
    await db.insert(
      'apply_mode',
      {'currentApplyMode': currentApplyMode},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // currentApplyMode 조회
  Future<int?> getCurrentApplyMode() async {
    final db = await database;

    final result = await db.query('apply_mode', limit: 1);

    if (result.isNotEmpty) {
      return result.first['currentApplyMode'] as int;
    }
    return null;
  }

  Future<void> saveActiveMode({
    required String welcome1,
    required List<String> welcome1Favorites,
    required String welcome2,
    required List<String> welcome2Favorites,
    required String weather,
    required String goodbye1,
    required List<String> goodbye1Favorites,
    required String goodbye2,
    required List<String> goodbye2Favorites,
    required String goodbye3,
    required List<String> goodbye3Favorites,
    required String nowSelectedCeremony, // 추가된 필드
  }) async {
    final db = await database;

    await db.delete('active_mode');
    await db.insert(
      'active_mode',
      {
        'welcome1': welcome1,
        'welcome1Favorites': jsonEncode(welcome1Favorites),
        'welcome2': welcome2,
        'welcome2Favorites': jsonEncode(welcome2Favorites),
        'weather': weather,
        'goodbye1': goodbye1,
        'goodbye1Favorites': jsonEncode(goodbye1Favorites),
        'goodbye2': goodbye2,
        'goodbye2Favorites': jsonEncode(goodbye2Favorites),
        'goodbye3': goodbye3,
        'goodbye3Favorites': jsonEncode(goodbye3Favorites),
        'now_selected_ceremony': nowSelectedCeremony, // 저장
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getActiveMode() async {
    final db = await database;

    final result = await db.query('active_mode', limit: 1);

    if (result.isNotEmpty) {
      final row = result.first;

      return {
        'welcome1': row['welcome1'] as String,
        'welcome1Favorites':
            jsonDecode(row['welcome1Favorites'] as String) as List<dynamic>,
        'welcome2': row['welcome2'] as String,
        'welcome2Favorites':
            jsonDecode(row['welcome2Favorites'] as String) as List<dynamic>,
        'weather': row['weather'] as String,
        'goodbye1': row['goodbye1'] as String,
        'goodbye1Favorites':
            jsonDecode(row['goodbye1Favorites'] as String) as List<dynamic>,
        'goodbye2': row['goodbye2'] as String,
        'goodbye2Favorites':
            jsonDecode(row['goodbye2Favorites'] as String) as List<dynamic>,
        'goodbye3': row['goodbye3'] as String,
        'goodbye3Favorites':
            jsonDecode(row['goodbye3Favorites'] as String) as List<dynamic>,
        'now_selected_ceremony': row['now_selected_ceremony'] as String, // 조회
      };
    }
    return null;
  }

  Future<void> saveCustomModes(List<Rx<CustomMode>> customModeModels) async {
    final db = await database;
    await db.delete('custom_modes'); // 기존 데이터 삭제

    for (var rxCustomMode in customModeModels) {
      final customMode = rxCustomMode.value;
      await db.insert(
        'custom_modes',
        {
          'apply': customMode.apply ? 1 : 0,
          'selectedBgCustomColor': customMode.selectedBgCustomColor.value,
          'customBgColors': jsonEncode(
              customMode.customBgColors.map((color) => color.value).toList()),
          'selectedSel1CustomColor': customMode.selectedSel1CustomColor.value,
          'customSel1Colors': jsonEncode(
              customMode.customSel1Colors.map((color) => color.value).toList()),
          'selectedSel2CustomColor': customMode.selectedSel2CustomColor.value,
          'customSel2Colors': jsonEncode(
              customMode.customSel2Colors.map((color) => color.value).toList()),
          'bgBright': customMode.bgBright,
          'bgVelocity': customMode.bgVelocity,
          'sel1Bright': customMode.sel1Bright,
          'sel1Velocity': customMode.sel1Velocity,
          'sel2Bright': customMode.sel2Bright,
          'sel2Velocity': customMode.sel2Velocity,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Rx<CustomMode>>> getCustomModes() async {
    final db = await database;
    final result = await db.query('custom_modes');

    return result.map((row) {
      return Rx(
        CustomMode(
          apply: (row['apply'] as int) == 1,
          selectedBgCustomColor: Color(row['selectedBgCustomColor'] as int),
          customBgColors:
              (jsonDecode(row['customBgColors'] as String) as List<dynamic>)
                  .map((colorValue) => Color(colorValue))
                  .toList(),
          selectedSel1CustomColor: Color(row['selectedSel1CustomColor'] as int),
          customSel1Colors:
              (jsonDecode(row['customSel1Colors'] as String) as List<dynamic>)
                  .map((colorValue) => Color(colorValue))
                  .toList(),
          selectedSel2CustomColor: Color(row['selectedSel2CustomColor'] as int),
          customSel2Colors:
              (jsonDecode(row['customSel2Colors'] as String) as List<dynamic>)
                  .map((colorValue) => Color(colorValue))
                  .toList(),
          bgBright: row['bgBright'] as double,
          bgVelocity: row['bgVelocity'] as double,
          sel1Bright: row['sel1Bright'] as double,
          sel1Velocity: row['sel1Velocity'] as double,
          sel2Bright: row['sel2Bright'] as double,
          sel2Velocity: row['sel2Velocity'] as double,
        ),
      );
    }).toList();
  }

  Future<void> saveLightingModel(Rx<LightingModel> lightingModelRx) async {
    final db = await database;
    final lightingModel = lightingModelRx.value;
    await db.delete('lighting_modes'); // 기존 데이터 삭제

    await db.insert(
      'lighting_modes',
      {
        'leftCenterColor': lightingModel.leftCenterColor.value,
        'leftCenterBright': lightingModel.leftCenterBright,
        'leftCenterFavorites': jsonEncode(lightingModel.leftCenterFavorites
            .map((color) => color.value)
            .toList()),
        'rightCenterColor': lightingModel.rightCenterColor.value,
        'rightCenterBright': lightingModel.rightCenterBright,
        'rightCenterFavorites': jsonEncode(lightingModel.rightCenterFavorites
            .map((color) => color.value)
            .toList()),
        'leftFirstDriverColor': lightingModel.leftFirstDriverColor.value,
        'leftFirstDriverBright': lightingModel.leftFirstDriverBright,
        'leftFirstDriverFavorites': jsonEncode(lightingModel
            .leftFirstDriverFavorites
            .map((color) => color.value)
            .toList()),
        'rightFirstPassengerColor':
            lightingModel.rightFirstPassengerColor.value,
        'rightFirstPassengerBright': lightingModel.rightFirstPassengerBright,
        'rightFirstPassengerFavorites': jsonEncode(lightingModel
            .rightFirstPassengerFavorites
            .map((color) => color.value)
            .toList()),
        'leftSecondDriverColor': lightingModel.leftSecondDriverColor.value,
        'leftSecondDriverBright': lightingModel.leftSecondDriverBright,
        'leftSecondDriverFavorites': jsonEncode(lightingModel
            .leftSecondDriverFavorites
            .map((color) => color.value)
            .toList()),
        'rightSecondPassengerColor':
            lightingModel.rightSecondPassengerColor.value,
        'rightSecondPassengerBright': lightingModel.rightSecondPassengerBright,
        'rightSecondPassengerFavorites': jsonEncode(lightingModel
            .rightSecondPassengerFavorites
            .map((color) => color.value)
            .toList()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Rx<LightingModel>> getLightingModel() async {
    final db = await database;
    final result = await db.query('lighting_modes', limit: 1);

    if (result.isNotEmpty) {
      final row = result.first;
      return Rx(
        LightingModel(
          leftCenterColor: Color(row['leftCenterColor'] as int),
          leftCenterBright: row['leftCenterBright'] as double,
          leftCenterFavorites: (jsonDecode(row['leftCenterFavorites'] as String)
                  as List<dynamic>)
              .map((colorValue) => Color(colorValue))
              .toList(),
          rightCenterColor: Color(row['rightCenterColor'] as int),
          rightCenterBright: row['rightCenterBright'] as double,
          rightCenterFavorites:
              (jsonDecode(row['rightCenterFavorites'] as String)
                      as List<dynamic>)
                  .map((colorValue) => Color(colorValue))
                  .toList(),
          leftFirstDriverColor: Color(row['leftFirstDriverColor'] as int),
          leftFirstDriverBright: row['leftFirstDriverBright'] as double,
          leftFirstDriverFavorites:
              (jsonDecode(row['leftFirstDriverFavorites'] as String)
                      as List<dynamic>)
                  .map((colorValue) => Color(colorValue))
                  .toList(),
          rightFirstPassengerColor:
              Color(row['rightFirstPassengerColor'] as int),
          rightFirstPassengerBright: row['rightFirstPassengerBright'] as double,
          rightFirstPassengerFavorites:
              (jsonDecode(row['rightFirstPassengerFavorites'] as String)
                      as List<dynamic>)
                  .map((colorValue) => Color(colorValue))
                  .toList(),
          leftSecondDriverColor: Color(row['leftSecondDriverColor'] as int),
          leftSecondDriverBright: row['leftSecondDriverBright'] as double,
          leftSecondDriverFavorites:
              (jsonDecode(row['leftSecondDriverFavorites'] as String)
                      as List<dynamic>)
                  .map((colorValue) => Color(colorValue))
                  .toList(),
          rightSecondPassengerColor:
              Color(row['rightSecondPassengerColor'] as int),
          rightSecondPassengerBright:
              row['rightSecondPassengerBright'] as double,
          rightSecondPassengerFavorites:
              (jsonDecode(row['rightSecondPassengerFavorites'] as String)
                      as List<dynamic>)
                  .map((colorValue) => Color(colorValue))
                  .toList(),
        ),
      );
    } else {
      throw Exception("LightingModel 데이터가 없습니다.");
    }
  }
}
