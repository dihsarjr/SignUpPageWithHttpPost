import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

class Drawers extends StatefulWidget {
  String emailUser;
  String nameUser;
  Drawers(this.emailUser, this.nameUser);

  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryList();
  }

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
                      widget.nameUser,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Text(
                  widget.emailUser,
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
//            leading: Icon(
//              Icons.home,
//              size: 30,
//            ),
            title: Text('Home'),
          ),
          ExpansionTile(
//            leading: Icon(
//              Icons.category,
//              size: 30,
//            ),
            title: Text('Category'),
            children: <Widget>[
              ExpansionTile(
//                leading: Icon(
//                  Icons.person,
//                  size: 30,
//                ),
                title: Text('Men'),
                children: <Widget>[
                  ExpansionTile(
//                    leading: Icon(
//                      Icons.add,
//                      size: 30,
//                    ),
                    title: Text('category 2'),
                    children: <Widget>[],
                  ),
                  ExpansionTile(
//                    leading: Icon(
//                      Icons.list,
//                      size: 30,
//                    ),
                    title: Text('category 3'),
                    children: <Widget>[],
                  ),
                  ExpansionTile(
//                    leading: Icon(
//                      Icons.insert_emoticon,
//                      size: 30,
//                    ),
                    title: Text('category 4'),
                    children: <Widget>[],
                  ),
                ],
              ),
              ExpansionTile(
//                leading: Icon(
//                  Icons.pregnant_woman,
//                  size: 30,
//                ),
                title: Text('Woman'),
                children: <Widget>[],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future getCategoryList() async {
    List<dynamic> categoryList;
    String url = "${GlobalConfiguration().getString("base_uri")}/categories";
    print(url);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print(res.body);
    print(res.statusCode.toString());
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      categoryList = data["data"] as List;
      print(categoryList);
//      print(res.body);
      //categoryList = rest.map<CategoryHead>((json) => CategoryHead.fromJson(json)).toList();
    }
    return categoryList;
  }
}
