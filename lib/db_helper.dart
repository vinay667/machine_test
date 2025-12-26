
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();

  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB("chat_db2.db");
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE chat_table2 (id INTEGER PRIMARY KEY, message TEXT, msg_time TEXT, filePath TEXT, message_type TEXT)',
        );
      },
    );
  }
}
