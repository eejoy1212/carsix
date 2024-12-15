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
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE music_modes (
            mode TEXT PRIMARY KEY,
            favorite TEXT, -- favorite colors as JSON string
            now INTEGER -- selected color (int value)
          )
        ''');
      },
    );
  }

  Future<void> saveMusicMode(
      {required String mode,
      required String favorite,
      required int now}) async {
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
}
