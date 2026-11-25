
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/guess.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance =
      DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = join(
      await getDatabasesPath(),
      'guesses.db',
    );

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE guesses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            number INTEGER,
            result TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertGuess(Guess guess) async {
    final db = await database;

    await db.insert(
      'guesses',
      guess.toMap(),
    );
  }

  Future<List<Guess>> getGuesses() async {
    final db = await database;
    final maps = await db.query('guesses');

    return List.generate(maps.length, (i) {
      return Guess(
        id: maps[i]['id'] as int,
        number: maps[i]['number'] as int,
        result: maps[i]['result'] as String,
      );
    });
  }
}
