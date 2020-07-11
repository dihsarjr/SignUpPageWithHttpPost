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
  List listViewData;
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

  @override
  Widget build(BuildContext context) {
    print(listViewData);
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
            leading: Icon(
              Icons.home,
              size: 30,
            ),
            title: Text('Home'),
          ),
          listViewData == null
              ? Text('loading')
              : Container(
                  height: 500,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        leading: Icon(Icons.shop),
                        title:
                            Text(listViewData[index]["categorygroup"]["name"]),
                        children: <Widget>[
                          Container(
                            height: 100,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  leading: Icon(Icons.shop),
                                  title: Text(listViewData[index]
                                          ["categorygroup"]
                                      ["category_sub_group"][0]["name"]),
                                );
                              },
                              itemCount: listViewData.length,
                            ),
                          ),
                        ],
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
