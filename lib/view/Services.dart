import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mvvm/view/login_view.dart';
import '../model/heirarchy_model.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'user_details8_database.db'),
      onCreate: (db, version) async {
        db.execute(
          'CREATE TABLE user_details(EmpDesignation TEXT, EmpCode TEXT PRIMARY KEY, EmpName TEXT, ReportTo TEXT, is_check INTEGER)',
        );
        db.execute(
          'CREATE TABLE team_company(Product_Company_Name TEXT, Product_Company_ID TEXT, is_check INTEGER)',
        );
        db.execute(
          'CREATE TABLE branch(Branch_Branch_Report_Name TEXT, Branch_Branch_Code TEXT, is_check INTEGER )',
        );
        db.execute(
          'CREATE TABLE IF NOT EXISTS selected_items(id INTEGER PRIMARY KEY, item TEXT)',
        );

      },
      version: 1,
    );
  }

Future<void> insert_heirarchy(UserDetails user) async {

  final Database db = await database;
  db.insert('user_details',
      {
      'EmpCode': empcode.auth,
      'EmpName': empcode.name,
      'is_check': 1,
      'ReportTo': empcode.auth,
      'EmpDesignation': empcode.designation
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
      );
  db.insert('user_details', user.toMap());
}

}