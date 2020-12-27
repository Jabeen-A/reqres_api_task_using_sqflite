import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqres_api_task/constants.dart';
import 'package:reqres_api_task/models/user.dart';
import 'package:reqres_api_task/provider/provider.dart';
import 'package:reqres_api_task/services/database_service.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _selectedIndex = 0;
  var newUsers;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getUser() async {
    final _userData = await DatabaseService.databaseService.getUser();
    return _userData;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
            onPressed: () => exit(0),
          ),
          title: Text(
            'Users',
            style: TextStyle(
              fontSize: width * 0.05,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        body: Consumer<AppProvider>(builder: (_, appProvider, __) {
          appProvider.getUsers();
          appProvider.getDBUsers();
          if (_selectedIndex == 0) {
            return Center(
              child: appProvider.users == null
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Text(
                          'Users from page ${appProvider.pageNumber}',
                          style: TextStyle(
                            fontSize: width * 0.06,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: appProvider.users.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Card(
                                  elevation: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5.0),
                                  child: Container(
                                    child: ListTile(
                                      onTap: () {
                                        var newDBUser = User(
                                          id: appProvider.users.data[index].id,
                                          firstName: appProvider
                                              .users.data[index].firstName,
                                          lastName: appProvider
                                              .users.data[index].lastName,
                                          email: appProvider
                                              .users.data[index].email,
                                          avatar: appProvider
                                              .users.data[index].avatar,
                                        );

                                        DatabaseService.databaseService
                                            .newUser(newDBUser, width);
                                      },
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      leading: Container(
                                        padding: EdgeInsets.only(right: 12.0),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    width: 1.0,
                                                    color: kGradientStart))),
                                        child: CircleAvatar(
                                          radius: width * 0.07,
                                          backgroundImage: NetworkImage(
                                              appProvider
                                                  .users.data[index].avatar),
                                        ),
                                      ),
                                      title: Text(
                                        appProvider
                                                .users.data[index].firstName +
                                            ' ' +
                                            appProvider
                                                .users.data[index].lastName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width * 0.05,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        appProvider.users.data[index].email,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.grey,
                                            fontSize: width * 0.04),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  if (appProvider.pageNumber > 1) {
                                    appProvider.pageNumber--;
                                  }
                                },
                                child: Visibility(
                                  visible: appProvider.pageNumber == 1
                                      ? false
                                      : true,
                                  child: Container(
                                    width: width * 0.15,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: appProvider.pageNumber == 1
                                          ? Colors.grey
                                          : kGradientEnd,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(2, 4),
                                            blurRadius: 5,
                                            spreadRadius: 2)
                                      ],
                                    ),
                                    child: Text(
                                      'Prev Page',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: width * 0.035,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                appProvider.users.page.toString() +
                                    '/' +
                                    appProvider.users.totalPages.toString(),
                                style: TextStyle(fontSize: width * 0.04),
                              ),
                              FlatButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  if (appProvider.pageNumber <
                                      appProvider.users.totalPages) {
                                    appProvider.pageNumber++;
                                  }
                                },
                                child: Visibility(
                                  visible: appProvider.pageNumber ==
                                          appProvider.users.totalPages
                                      ? false
                                      : true,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: appProvider.pageNumber ==
                                              appProvider.users.totalPages
                                          ? Colors.grey
                                          : kGradientEnd,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(2, 4),
                                            blurRadius: 5,
                                            spreadRadius: 2)
                                      ],
                                    ),
                                    child: Text(
                                      'Next Page',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: width * 0.035,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            );
          } else {
            return Center(
              child: appProvider.dbUsers == null
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Text(
                          'Users from Database',
                          style: TextStyle(
                            fontSize: width * 0.06,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Expanded(
                          child: appProvider.dbUsers.length == 0
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 100),
                                  child: Text(
                                    'There\'s no user in DB. Please click a user profile to add in DB.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: width * 0.05,
                                      fontFamily: 'Roboto',
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: appProvider.dbUsers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      child: Card(
                                        elevation: 8.0,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 8),
                                        child: Container(
                                          child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.0,
                                                    vertical: 10.0),
                                            leading: Container(
                                              padding:
                                                  EdgeInsets.only(right: 12.0),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: 1.0,
                                                          color:
                                                              kGradientStart))),
                                              child: CircleAvatar(
                                                radius: width * 0.07,
                                                backgroundImage: NetworkImage(
                                                    appProvider.dbUsers[index]
                                                        ['avatar']),
                                              ),
                                            ),
                                            title: Text(
                                              appProvider.dbUsers[index]
                                                      ['firstName'] +
                                                  ' ' +
                                                  appProvider.dbUsers[index]
                                                      ['lastName'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: width * 0.05,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              appProvider.dbUsers[index]
                                                  ['email'],
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: Colors.grey,
                                                  fontSize: width * 0.04),
                                            ),
                                            trailing: IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                DatabaseService.databaseService
                                                    .removeUser(
                                                        appProvider
                                                                .dbUsers[index]
                                                            ['email'],
                                                        (appProvider.dbUsers[
                                                                    index]
                                                                ['firstName'] +
                                                            ' ' +
                                                            appProvider.dbUsers[
                                                                    index]
                                                                ['lastName']),
                                                        width);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
            );
          }
        }),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'List from API',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'List from DB',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kGradientEnd,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
