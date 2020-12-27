import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:reqres_api_task/constants.dart';
import 'package:reqres_api_task/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:reqres_api_task/services/database_service.dart';

class AppProvider extends ChangeNotifier {
  Users users;
  var dbUsers = [];
  int pageNumber = 1;
  getUsers() async {
    var usersResponse = await http.get(kGetUsersURL + pageNumber.toString());
    if (usersResponse.statusCode == 200) {
      var jsonUsersResponse = jsonDecode(usersResponse.body);
      users = Users.fromJson(jsonUsersResponse);
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  getDBUsers() async {
    dbUsers = await DatabaseService.databaseService.getUser();
    if (!(dbUsers.toString() == '[]' && dbUsers != null)) {
      notifyListeners();
    }
  }
}
