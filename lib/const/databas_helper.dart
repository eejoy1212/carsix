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
    final databasePath = join(path, 'colors.db');

    return await openDatabase(
      databasePath,
      version: 4, // 테이블 구조 수정으로 버전 업데이트
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE music_modes (
            mode TEXT PRIMARY KEY,
            favorite TEXT, -- favorite colors as JSON string
            now INTEGER -- selected color (int value)
          )
        ''');

        await db.execute('''
          CREATE TABLE custom_modes (
            mode TEXT PRIMARY KEY, -- 모드 번호
            bgFavorite TEXT, -- 배경 즐겨찾기 색상
            bgNow INTEGER, -- 현재 배경 색상
            sel1Favorite TEXT, -- 선택 영역 1 즐겨찾기 색상
            sel1Now INTEGER, -- 현재 선택 영역 1 색상
            sel2Favorite TEXT, -- 선택 영역 2 즐겨찾기 색상
            sel2Now INTEGER -- 현재 선택 영역 2 색상
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          // 테이블 수정 - 새로운 컬럼 추가
          await db.execute("DROP TABLE IF EXISTS custom_modes");
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
        }
      },
    );
  }

  // 음악 모드 저장
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
}
