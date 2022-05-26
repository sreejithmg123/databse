import 'dart:convert';
import 'dart:io';
import 'package:databse/models/employee.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, 'employees.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE employees(
  id INTEGER PRIMARY KEY,
  name TEXT,
  username TEXT,
  email TEXT,
  profile_image TEXT,
  phone TEXT,
  website TEXT
)
''');
  }

  Future<List<Employee>> getEmployees() async {
    Database db = await instance.database;

    var employees = await db.query('employees', orderBy: 'id');
    List<Employee> employeeList = employees.isNotEmpty
        ? employees.map((e) => Employee.fromJson(e)).toList()
        : [];
    return employeeList;
  }

  Future<int> add(Employee employee) async {
    Database db = await instance.database;

    return await db.insert('employees', employee.toJson());
  }

  Future<List<Employee>> searchEmployee(String keyword) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> employees = await db
        .query('employees', where: 'name LIKE ?', whereArgs: ['%$keyword']);
    List<Employee> employeeList =
        employees.map((e) => Employee.fromJson(e)).toList();
    return employeeList;
  }
}
