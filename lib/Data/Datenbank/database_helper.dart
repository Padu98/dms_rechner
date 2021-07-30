import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTableOne';
  static final _columnId = '_id';
  static final _columnName = 'name';
  static final _sex = 'sex';
  static final _50s = '50s';
  static final _100s = '100s';
  static final _200s = '200s';
  static final _50r = '50r';
  static final _100r = '100r';
  static final _200r = '200r';
  static final _50b = '50b';
  static final _100b = '100b';
  static final _200b = '200b';
  static final _50f = '50f';
  static final _100f = '100f';
  static final _200f = '200f';
  static final _400f = '400f';
  static final _800f = '800f';
  static final _1500f = '1500f';
  static final _100l = '100l';
  static final _200l = '200l';
  static final _400l = '400l';
  static final _columnImg = "userImg";

  static Database _database;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  bool isNotEmpty(){
    if(database!=null){
      return true;}
    else{
      return false;}
  }


  Future<Database> get database async {
    if (_database != null) return _database;


    _database = await _initiateDatabase();
    return _database;
  }


  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);


    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE $_tableName(
    $_columnId INTEGER PRIMARY KEY,
    $_columnName TEXT NOT NULL,
    $_sex TEXT NOT NULL,
    $_50s INTEGER,
    $_100s INTEGER,
    $_200s INTEGER,
    $_50r INTEGER,
    $_100r INTEGER,
    $_200r INTEGER,
    $_50b INTEGER,
    $_100b INTEGER,
    $_200b INTEGER,
    $_50f INTEGER,
    $_100f INTEGER,
    $_200f INTEGER,
    $_400f INTEGER,
    $_800f INTEGER,
    $_1500f INTEGER,
    $_100l INTEGER,
    $_200l INTEGER,
    $_400l INTEGER,
    $_columnImg TEXT NOT NULL   
    ''');
  }

  Future<int> insert(Map<String, dynamic>row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future <List <Map <String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[_columnId];
    return db.update(_tableName, row, where: '$_columnId = ?', whereArgs: [id]);
  }

  Future <int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
        _tableName, where: '$_columnId = ?', whereArgs: [id]);
  }

}