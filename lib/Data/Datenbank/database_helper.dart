import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTableOne';
  static final _columnId = 'id';
  static final _columnName = 'name';
  static final _sex = 'sex';
  static final _50s = '_50s';
  static final _100s = '_100s';
  static final _200s = '_200s';
  static final _50r = '_50r';
  static final _100r = '_100r';
  static final _200r = '_200r';
  static final _50b = '_50b';
  static final _100b = '_100b';
  static final _200b = '_200b';
  static final _50f = '_50f';
  static final _100f = '_100f';
  static final _200f = '_200f';
  static final _400f = '_400f';
  static final _800f = '_800f';
  static final _1500f = '_1500f';
  static final _100l = '_100l';
  static final _200l = '_200l';
  static final _400l = '_400l';
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
    $_columnId TEXT NOT NULL PRIMARY KEY,
    $_columnName TEXT NOT NULL,
    $_sex TEXT NOT NULL,
    $_50s TEXT NOT NULL,
    $_100s TEXT NOT NULL,
    $_200s TEXT NOT NULL,
    $_50r TEXT NOT NULL,
    $_100r TEXT NOT NULL,
    $_200r TEXT NOT NULL,
    $_50b TEXT NOT NULL,
    $_100b TEXT NOT NULL,
    $_200b TEXT NOT NULL,
    $_50f TEXT NOT NULL,
    $_100f TEXT NOT NULL,
    $_200f TEXT NOT NULL,
    $_400f TEXT NOT NULL,
    $_800f TEXT NOT NULL,
    $_1500f TEXT NOT NULL,
    $_100l TEXT NOT NULL,
    $_200l TEXT NOT NULL,
    $_400l TEXT NOT NULL,
    $_columnImg TEXT NOT NULL)  
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