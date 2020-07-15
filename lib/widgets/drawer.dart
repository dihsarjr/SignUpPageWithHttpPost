import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:registration/category_det.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

class Drawers extends StatefulWidget {
  String emailUser;
  String nameUser;
  Drawers(this.emailUser, this.nameUser);

  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  List listViewData;

  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryList();
    getData();
  }

//GET DATA FROM FUTURE FUNCTION
  getData() async {
    await getCategoryList().then((v) {
      v != null
          ? setState(() {
              listViewData = v;
            })
          : setState(() {
              listViewData = null;
            });
    });
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("email");
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    print(listViewData);
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            color: Color(0xFFEDA89D),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                  ),
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
                ),
                RaisedButton(
                    child: Text('Log Out'),
                    onPressed: () {
                      removeValues();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    })
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
          listViewData == null
              ? Text('loading')
              : Container(
                  height: 550,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.shop),
                        title:
                            Text(listViewData[index]["categorygroup"]["name"]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryDet(
                                      listViewData[index]["categorygroup"]
                                          ["category_sub_group"])));
                        },
                      );
                    },
                    itemCount: listViewData.length,
                  ),
                ),
        ],
      ),
    );
  }

  Future getCategoryList() async {
    List<dynamic> categoryList;
    var v = categoryList;
    String url = "${GlobalConfiguration().getString("base_uri")}/categories";
    print(url);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//    print(res.body);
    print(res.statusCode.toString());
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      categoryList = data["data"] as List;

      print(categoryList[0]["categorygroup"]["category_sub_group"][0]["name"]);

//      print(res.body);
      //categoryList = rest.map<CategoryHead>((json) => CategoryHead.fromJson(json)).toList();
    }
    return categoryList;
  }
}
