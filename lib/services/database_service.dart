import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:reqres_api_task/constants.dart';
import 'package:reqres_api_task/models/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService databaseService = DatabaseService._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'reqres.db'),
        onCreate: (db, version) async {
      await db.execute(kDBCreateQuery);
    }, version: 1);
  }

  newUser(User newUser, double width) async {
    final db = await database;

    var searchResult = await db.query("users");

    searchResult.forEach((element) {
      if (element['email'] == newUser.email) {
        Fluttertoast.showToast(
            msg:
                '${newUser.firstName} ${newUser.lastName} is already added in DB',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            fontSize: width * 0.03,
            textColor: Colors.white);

        return null;
      }
    });

    var result = await db.rawInsert(kDBAddUserQuery,
        [newUser.firstName, newUser.lastName, newUser.email, newUser.avatar]);

    Fluttertoast.showToast(
        msg:
            '${newUser.firstName} ${newUser.lastName} was added successfully in DB',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        fontSize: width * 0.03,
        textColor: Colors.white);

    return result;
  }

  removeUser(String email, String name, double width) async {
    final db = await database;

    var removeResult = await db.rawDelete(kDBRemoveUserQuery, [email]);
    print(removeResult.toString());

    Fluttertoast.showToast(
        msg: '$name was removed successfully from DB',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        fontSize: width * 0.03,
        textColor: Colors.white);
  }

  Future<dynamic> getUser() async {
    final db = await database;

    var result = await db.query("users");

    if (result.length == 0)
      return [];
    else {
      return result.isNotEmpty ? result : Null;
    }
  }
}
