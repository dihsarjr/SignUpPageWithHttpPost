import 'package:flutter/material.dart';

class Drawers extends StatelessWidget {
  String emailUser;
  String nameUser;
  Drawers(this.emailUser, this.nameUser);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.pink,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      nameUser,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Text(
                  emailUser,
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              size: 30,
            ),
            title: Text('Home'),
          ),
          ExpansionTile(
            leading: Icon(
              Icons.category,
              size: 30,
            ),
            title: Text('Category'),
            children: <Widget>[
              ExpansionTile(
                leading: Icon(
                  Icons.person,
                  size: 30,
                ),
                title: Text('Men'),
                children: <Widget>[
                  ExpansionTile(
                    leading: Icon(
                      Icons.add,
                      size: 30,
                    ),
                    title: Text('category 2'),
                    children: <Widget>[],
                  ),
                  ExpansionTile(
                    leading: Icon(
                      Icons.list,
                      size: 30,
                    ),
                    title: Text('category 3'),
                    children: <Widget>[],
                  ),
                  ExpansionTile(
                    leading: Icon(
                      Icons.insert_emoticon,
                      size: 30,
                    ),
                    title: Text('category 4'),
                    children: <Widget>[],
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.pregnant_woman,
                  size: 30,
                ),
                title: Text('Woman'),
                children: <Widget>[],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
