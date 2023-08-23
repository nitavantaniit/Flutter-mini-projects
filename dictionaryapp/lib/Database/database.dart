import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _database;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<void> initializeDatabase() async {
    String path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'dictionary.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE words(
            id INTEGER PRIMARY KEY,
            word TEXT,
            meaning TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllWords() async {
    await initializeDatabase();
    return await _database.query('words');
  }

  Future<void> addWord(Map<String, dynamic> wordMap) async {
    await initializeDatabase();
    await _database.insert('words', wordMap);
  }

  Future<void> editWord(int id, Map<String, dynamic> wordMap) async {
    await initializeDatabase();
    await _database.update(
      'words',
      wordMap,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteWord(int id) async {
    await initializeDatabase();
    await _database.delete(
      'words',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>> getWordById(int id) async {
    await initializeDatabase();
    List<Map<String, dynamic>> results = await _database.query(
      'words',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return {}; // Return an empty map if no word is found
  }
}
