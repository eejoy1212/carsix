//1.원본
// import 'dart:convert';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;

//   static Database? _database;

//   DatabaseHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB();
//     return _database!;
//   }

//   Future<Database> _initDB() async {
//     final path = await getDatabasesPath();
//     final databasePath = join(path, 'carsix_8.db');

//     return await openDatabase(
//       databasePath,
//       version: 8, // 버전 업데이트
//       onCreate: (db, version) async {
//         await db.execute('''
//         CREATE TABLE music_modes (
//           mode TEXT PRIMARY KEY,
//           favorite TEXT,
//           now INTEGER
//         )
//       ''');

//         await db.execute('''
//         CREATE TABLE custom_modes (
//           mode TEXT PRIMARY KEY,
//           bgFavorite TEXT,
//           bgNow INTEGER,
//           sel1Favorite TEXT,
//           sel1Now INTEGER,
//           sel2Favorite TEXT,
//           sel2Now INTEGER
//         )
//       ''');

//         await db.execute('''
//         CREATE TABLE apply_mode (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           currentApplyMode INTEGER
//         )
//       ''');

//         // active_mode 테이블 생성
//         await db.execute('''
//           CREATE TABLE active_mode (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             welcome1 TEXT,
//             welcome1Favorites TEXT,
//             welcome2 TEXT,
//             welcome2Favorites TEXT,
//             weather TEXT,
//             goodbye1 TEXT,
//             goodbye1Favorites TEXT,
//             goodbye2 TEXT,
//             goodbye2Favorites TEXT,
//             goodbye3 TEXT,
//             goodbye3Favorites TEXT,
//             now_selected_ceremony TEXT -- 새로 추가된 필드
//           )
//         ''');
//       },
//       onUpgrade: (db, oldVersion, newVersion) async {
//         if (oldVersion < 8) {
//           await db.execute(
//               'ALTER TABLE active_mode ADD COLUMN now_selected_ceremony TEXT');
//         }
//       },
//     );
//   }

//   Future<void> saveMusicMode({
//     required String mode,
//     required String favorite,
//     required int now,
//   }) async {
//     final db = await database;
//     await db.insert(
//       'music_modes',
//       {'mode': mode, 'favorite': favorite, 'now': now},
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<Map<String, dynamic>?> getMusicMode(String mode) async {
//     final db = await database;
//     final result =
//         await db.query('music_modes', where: 'mode = ?', whereArgs: [mode]);
//     return result.isNotEmpty ? result.first : null;
//   }

//   // 커스텀 모드 저장
//   Future<void> saveCustomMode({
//     required String mode,
//     required String bgFavorite,
//     required int bgNow,
//     required String sel1Favorite,
//     required int sel1Now,
//     required String sel2Favorite,
//     required int sel2Now,
//   }) async {
//     final db = await database;

//     await db.insert(
//       'custom_modes',
//       {
//         'mode': mode,
//         'bgFavorite': bgFavorite,
//         'bgNow': bgNow,
//         'sel1Favorite': sel1Favorite,
//         'sel1Now': sel1Now,
//         'sel2Favorite': sel2Favorite,
//         'sel2Now': sel2Now,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // 커스텀 모드 조회
//   Future<Map<String, dynamic>?> getCustomMode(String mode) async {
//     final db = await database;
//     final result =
//         await db.query('custom_modes', where: 'mode = ?', whereArgs: [mode]);

//     print("커스텀 모드 조회 결과 >>> $result");

//     return result.isNotEmpty ? result.first : null;
//   }

//   // 커스텀 모드 타입과 모드에 맞는 조회
//   Future<Map<String, dynamic>?> getCustomTypeColor({
//     required String mode,
//     required String bgFavorite,
//   }) async {
//     final db = await database;

//     final result = await db.query(
//       'custom_modes',
//       where: 'mode = ? AND bgFavorite = ?',
//       whereArgs: [mode, bgFavorite],
//     );

//     print("커스텀 모드 조회 결과 >>> $result");

//     return result.isNotEmpty ? result.first : null;
//   }

//   // currentApplyMode 저장
//   Future<void> saveCurrentApplyMode(int currentApplyMode) async {
//     final db = await database;

//     // 기존 데이터를 삭제하고 새로운 데이터를 저장
//     await db.delete('apply_mode');
//     await db.insert(
//       'apply_mode',
//       {'currentApplyMode': currentApplyMode},
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // currentApplyMode 조회
//   Future<int?> getCurrentApplyMode() async {
//     final db = await database;

//     final result = await db.query('apply_mode', limit: 1);

//     if (result.isNotEmpty) {
//       return result.first['currentApplyMode'] as int;
//     }
//     return null;
//   }

//   Future<void> saveActiveMode({
//     required String welcome1,
//     required List<String> welcome1Favorites,
//     required String welcome2,
//     required List<String> welcome2Favorites,
//     required String weather,
//     required String goodbye1,
//     required List<String> goodbye1Favorites,
//     required String goodbye2,
//     required List<String> goodbye2Favorites,
//     required String goodbye3,
//     required List<String> goodbye3Favorites,
//     required String nowSelectedCeremony, // 추가된 필드
//   }) async {
//     final db = await database;

//     await db.delete('active_mode');
//     await db.insert(
//       'active_mode',
//       {
//         'welcome1': welcome1,
//         'welcome1Favorites': jsonEncode(welcome1Favorites),
//         'welcome2': welcome2,
//         'welcome2Favorites': jsonEncode(welcome2Favorites),
//         'weather': weather,
//         'goodbye1': goodbye1,
//         'goodbye1Favorites': jsonEncode(goodbye1Favorites),
//         'goodbye2': goodbye2,
//         'goodbye2Favorites': jsonEncode(goodbye2Favorites),
//         'goodbye3': goodbye3,
//         'goodbye3Favorites': jsonEncode(goodbye3Favorites),
//         'now_selected_ceremony': nowSelectedCeremony, // 저장
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<Map<String, dynamic>?> getActiveMode() async {
//     final db = await database;

//     final result = await db.query('active_mode', limit: 1);

//     if (result.isNotEmpty) {
//       final row = result.first;

//       return {
//         'welcome1': row['welcome1'] as String,
//         'welcome1Favorites':
//             jsonDecode(row['welcome1Favorites'] as String) as List<dynamic>,
//         'welcome2': row['welcome2'] as String,
//         'welcome2Favorites':
//             jsonDecode(row['welcome2Favorites'] as String) as List<dynamic>,
//         'weather': row['weather'] as String,
//         'goodbye1': row['goodbye1'] as String,
//         'goodbye1Favorites':
//             jsonDecode(row['goodbye1Favorites'] as String) as List<dynamic>,
//         'goodbye2': row['goodbye2'] as String,
//         'goodbye2Favorites':
//             jsonDecode(row['goodbye2Favorites'] as String) as List<dynamic>,
//         'goodbye3': row['goodbye3'] as String,
//         'goodbye3Favorites':
//             jsonDecode(row['goodbye3Favorites'] as String) as List<dynamic>,
//         'now_selected_ceremony': row['now_selected_ceremony'] as String, // 조회
//       };
//     }
//     return null;
//   }
// }
// 2.단색 모드 추가
import 'dart:convert';

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
    final databasePath = join(path, 'carsix_9.db');

    return await openDatabase(
      databasePath,
      version: 9, // 버전 업데이트
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE music_modes (
          mode TEXT PRIMARY KEY,
          favorite TEXT,
          now INTEGER
        )
      ''');

        await db.execute('''
        CREATE TABLE custom_modes (
          mode TEXT PRIMARY KEY,
          bgFavorite TEXT,
          bgNow INTEGER,
          sel1Favorite TEXT,
          sel1Now INTEGER,
          sel2Favorite TEXT,
          sel2Now INTEGER
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
      },
    );
  }

  Future<void> saveMusicMode({
    required String mode,
    required String favorite,
    required int now,
  }) async {
    final db = await database;
    await db.insert(
      'music_modes',
      {'mode': mode, 'favorite': favorite, 'now': now},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getMusicMode(String mode) async {
    final db = await database;
    final result =
        await db.query('music_modes', where: 'mode = ?', whereArgs: [mode]);
    return result.isNotEmpty ? result.first : null;
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
}
