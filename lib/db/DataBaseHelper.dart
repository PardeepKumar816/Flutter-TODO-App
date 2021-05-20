import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DataBaseHelper extends ChangeNotifier{

  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTable';
  static final columnId = '_id';
  static final columnName = 'name';

  //making it a singleton class
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async{
    if(_database!=null)  return _database;

    _database = await _initiatDatabase();
    return _database;
  }

  _initiatDatabase () async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dbName);
    return await openDatabase(path,version: _dbVersion,onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version){
    db.execute(
    ''' 
    CREATE TABLE $_tableName(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL
    )
    '''
    );
  }

  Future<int> insert(Map<String,dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String,dynamic>>> queryAll() async {
     Database db = await instance.database;
     return await db.query(_tableName);
  }

  Future<int> update(Map<String,dynamic> row) async{
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(_tableName, row,where: '$columnId = ?',whereArgs:[id]);
  }

  Future<int> delete(int id) async{
    Database db = await instance.database;
    return await db.delete(_tableName,where: '$columnId = ?',whereArgs: [id]);
  }
}