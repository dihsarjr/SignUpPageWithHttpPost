import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:registration/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageOne extends StatefulWidget {
  @override
  _HomePageOneState createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> {
  final List<NewArrivalsModels> newArrivals = [
    NewArrivalsModels(
      'https://images.unsplash.com/photo-1591375372509-68d11e1390df?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
    ),
    NewArrivalsModels(
        'https://images.unsplash.com/photo-1542406915-20eac16493d2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    NewArrivalsModels(
        'https://images.unsplash.com/photo-1502185635613-0a5b2e78efea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    NewArrivalsModels(
        'https://images.unsplash.com/photo-1546304696-bc6099d9e346?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    NewArrivalsModels(
        'https://images.unsplash.com/photo-1585565804112-f201f68c48b4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    NewArrivalsModels(
        'https://images.unsplash.com/photo-1556740714-a8395b3bf30f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    NewArrivalsModels(
      'https://images.unsplash.com/photo-1591375372509-68d11e1390df?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
    ),
  ];

  String _emails = '';

  String _passs = '';

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emails = (prefs.getString('email') ?? '');
      _passs = (prefs.getString('name') ?? '');
    });
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("email");
  }

  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = Container(
      height: 250,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          NetworkImage(newArrivals[0].image),
          NetworkImage(newArrivals[1].image),
          NetworkImage(newArrivals[2].image),
          NetworkImage(newArrivals[3].image),
          NetworkImage(newArrivals[4].image),
          NetworkImage(newArrivals[5].image),
        ],
        autoplay: true,
        indicatorBgPadding: 1,
        dotColor: Color(0xFFee9ca7),
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
      ),
    );
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFEDA89D),
              title: Text('welcome'),
            ),
            drawer: Drawers(_emails, _passs),
            body: Column(
              children: <Widget>[
                imageCarousel,
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Text(
                            'Trending Now',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child: Text(
                            'View All',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 195,
                              width: 200,
                              color: Colors.green,
                            ),
                          );
                        },
                        itemCount: 5,
                      ),
                    ),
                  ],
                )
              ],
            )));
  }

  Future getCategoryList() async {
    List<dynamic> categoryList;
    var v = categoryList;
    String url = "${GlobalConfiguration().getString("base_uri")}/trending_now";
    print(url);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//    print(res.body);
    print(res.statusCode.toString());
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      categoryList = data["data"] as List;

      print(categoryList[1]['brand']);

//      print(res.body);
      //categoryList = rest.map<CategoryHead>((json) => CategoryHead.fromJson(json)).toList();
    }
    return categoryList;
  }
}

class NewArrivalsModels {
  String image;
  NewArrivalsModels(this.image);
}
