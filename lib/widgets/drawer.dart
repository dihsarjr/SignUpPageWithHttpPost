import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration/cart.dart';
import 'package:registration/categorys.dart';
import 'package:registration/my_orders.dart';
import 'package:registration/support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';
import '../wish_list.dart';

class Drawers extends StatefulWidget {
  String emailUser;
  String nameUser;
  String userIds;
  List listViewData;
  Drawers(this.emailUser, this.nameUser, this.userIds, this.listViewData);

  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  List data;

//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    getCategoryList();
//    getData();
//  }
//
////GET DATA FROM FUTURE FUNCTION
//  getData() async {
//    await getCategoryList().then((v) {
//      v != null
//          ? setState(() {
//              listViewData = v;
//            })
//          : setState(() {
//              listViewData = null;
//            });
//    });
//  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("email");
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    print(widget.listViewData);
    return Drawer(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(150),
                bottomLeft: Radius.circular(150)),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                    colors: [Color(0xFF3d60ff), Color(0xFF7550ff)]),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.nameUser == ''
                          ? Text(
                              'NAME',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          : Text(
                              widget.nameUser,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                    ),
                    Text(
                      widget.emailUser,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        size: 20,
                      ),
                      title: Text('Home'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.favorite,
                        size: 20,
                      ),
                      title: Text('Wishlist'),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WishList()));
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.shopping_cart,
                        size: 20,
                      ),
                      title: Text('Cart'),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Cart()));
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.shopping_basket,
                        size: 20,
                      ),
                      title: Text('My Orders'),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyOrders(widget.userIds)));
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.category,
                        size: 20,
                      ),
                      title: Text('Categories'),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryList(widget.listViewData)));
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.contact_mail,
                        size: 20,
                      ),
                      title: Text('Contact Us'),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SupportScreen()));
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        size: 20,
                      ),
                      title: Text('Log Out'),
                      onTap: () {
                        removeValues();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

//          widget.listViewData == null
//              ? Text('loading')
//              : Container(
//                  height: MediaQuery.of(context).size.height * 0.50,
//                  child: ListView.builder(
//                    itemBuilder: (context, index) {
//                      return ListTile(
//                        leading: Icon(Icons.shop),
//                        title: Text(widget.listViewData[index]["categorygroup"]
//                            ["name"]),
//                        onTap: () {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => CategoryDet(widget
//                                          .listViewData[index]["categorygroup"]
//                                      ["category_sub_group"])));
//                        },
//                      );
//                    },
//                    itemCount: widget.listViewData.length,
//                  ),
//                ),
        ],
      ),
    );
  }

//  Future getCategoryList() async {
//    List<dynamic> categoryList;
//    var v = categoryList;
//    String url = "${GlobalConfiguration().getString("base_uri")}/categories";
//    print(url);
//    var res = await http
//        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
////    print(res.body);
//    print(res.statusCode.toString());
//    if (res.statusCode == 200) {
//      var data = json.decode(res.body);
//      categoryList = data["data"] as List;
//
//      print(categoryList[0]["categorygroup"]["category_sub_group"][0]["name"]);
//
////      print(res.body);
//      //categoryList = rest.map<CategoryHead>((json) => CategoryHead.fromJson(json)).toList();
//    }
//    return categoryList;
//  }
}
