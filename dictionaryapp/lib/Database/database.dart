import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableWords = 'words';
final String colId = 'id';
final String colWord = 'word';
final String colMeaning = 'meaning';
final String colDescription = 'description';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'dictionary.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableWords (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colWord TEXT NOT NULL,
        $colMeaning TEXT NOT NULL,
        $colDescription TEXT
      )
    ''');
  }

  Future<int> insertWord(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableWords, row);
  }

  Future<List<Map<String, dynamic>>> getAllWords() async {
    Database db = await instance.database;
    return await db.query(tableWords);
  }

  Future<int> updateWord(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(tableWords, row, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> deleteWord(int id) async {
    Database db = await instance.database;
    return await db.delete(tableWords, where: '$colId = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>> getWordById(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableWords, where: '$colId = ?', whereArgs: [id]);
    return maps.first;
  }

  Future<Map<String, dynamic>> getWordByWord(String word) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableWords, where: '$colWord = ?', whereArgs: [word]);
    return maps.first;
  }
}
