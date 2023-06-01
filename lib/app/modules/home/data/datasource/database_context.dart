import 'package:sqflite/sqflite.dart';

class DatabaseContext {
  late Database database;
  Future<void> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath\book.db";
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('Create table books (id TEXT PRIMARY Key, book TEXT)');
      },
    );
  }
}
