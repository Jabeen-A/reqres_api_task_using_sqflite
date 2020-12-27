import 'package:flutter/material.dart';

const kGradientStart = Color(0xff67B26F);
const kGradientEnd = Color(0xff4ca2cd);

const kLoginURL = 'https://reqres.in/api/login';
const kGetUsersURL = 'http://reqres.in/api/users?page=';

const kDBCreateQuery = ''' CREATE TABLE users (
        firstName TEXT, lastName TEXT, email TEXT PRIMARY KEY, avatar TEXT
      ) ''';

const kDBAddUserQuery = ''' INSERT INTO users (
  firstName, lastName, email, avatar
) VALUES (?, ?, ?, ?) ''';

const kDBRemoveUserQuery = ''' DELETE FROM users WHERE email = ? ''';
