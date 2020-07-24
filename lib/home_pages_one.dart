import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:registration/trending_now_page.dart';
import 'package:registration/widgets/drawer.dart';
import 'package:registration/widgets/trending_now.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'full_detailed_view.dart';

class HomePageOne extends StatefulWidget {
  @override
  _HomePageOneState createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> {
  List listViewData;
  List listViewDataA;
  List listViewDataWeekly;
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
  String _userId = '';

  @override
  void initState() {
    super.initState();
    _loadCounter();
    getCategoryList();
    getData();
    getWeeklyList();
    getDataWeekly();
    _getCategoryList();
    _getData();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emails = (prefs.getString('email') ?? '');
      _passs = (prefs.getString('name') ?? '');
      _userId = (prefs.getString('id') ?? '');
    });
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("email");
  }

  getDataWeekly() async {
    await getWeeklyList().then((v) {
      v != null
          ? setState(() {
              listViewDataWeekly = v;
              print(listViewDataWeekly);
            })
          : setState(() {
              listViewDataWeekly = null;
            });
    });
  }

  //GET DATA FROM FUTURE FUNCTION
  getData() async {
    await getCategoryList().then((v) {
      v != null
          ? setState(() {
              listViewData = v;
              print(listViewData);
            })
          : setState(() {
              listViewData = null;
            });
    });
  }

  _getData() async {
    await _getCategoryList().then((v) {
      v != null
          ? setState(() {
              listViewDataA = v;
            })
          : setState(() {
              listViewDataA = null;
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = Container(
      height: MediaQuery.of(context).size.height * 0.28,
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
        indicatorBgPadding: 5,
        dotColor: Colors.grey,
        dotSize: 4,
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
      ),
    );
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                'Shop',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              iconTheme: new IconThemeData(color: Colors.black),
            ),
            drawer: Drawers(
              _emails,
              _passs,
              _userId,
              listViewDataA,
            ),
            body: Builder(builder: (BuildContext context) {
              return OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      child,
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        height: 32.0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          color: connected
                              ? Colors.transparent
                              : Color(0xFFEE4400),
                          child: connected
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "OFFLINE",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                      height: 12.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  );
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      imageCarousel,
                      Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 20, bottom: 8),
                                  child: Text(
                                    'Trending Now',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 20),
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      'View All',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black54),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TrendingNowPage(
                                                      listViewData)));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 210,
                            color: Colors.white,
                            child: listViewData == null
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 200,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                offset: Offset(-6.0, -6.0),
                                                blurRadius: 16.0,
                                              ),
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                offset: Offset(6.0, 6.0),
                                                blurRadius: 16.0,
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              CircularProgressIndicator(
                                                valueColor:
                                                    new AlwaysStoppedAnimation<
                                                        Color>(Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: 5,
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TrendingNow(
                                              listViewData[index]['image'],
                                              listViewData[index]['title'],
                                              listViewData[index]['sale_price'],
                                              listViewData[index]['brand'],
                                              listViewData[index]['id']
                                                  .toString(),
                                              listViewData[index]
                                                  ['inventory_id'],
                                            )),
                                      );
                                    },
                                    itemCount: 6,
                                  ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 15,
                          bottom: 10,
                        ),
                        child: Text(
                          'Weekly popular',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      listViewDataWeekly == null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: (1 / 1),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (ctx, index) {
                                  return FlatButton(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                              child: CircularProgressIndicator(
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.black),
                                          ))
                                        ],
                                      ),
                                    ),
                                    onPressed: () {},
                                  );
                                },
                                itemCount: 5,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: (1 / 1),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (ctx, index) {
                                  String title =
                                      listViewDataWeekly[index]['title'];
                                  String image =
                                      listViewDataWeekly[index]['image'];
                                  String brand =
                                      listViewDataWeekly[index]['brand'];
                                  String condition =
                                      listViewDataWeekly[index]['condition'];
                                  String conditionNote;
                                  String description =
                                      listViewDataWeekly[index]['description'];
                                  String price =
                                      'price :${listViewDataWeekly[index]['sale_price']}';
                                  String idOne = listViewDataWeekly[index]['id']
                                      .toString();
                                  String productId = listViewDataWeekly[index]
                                          ['product_id']
                                      .toString();
                                  String slug =
                                      listViewDataWeekly[index]['inventory_id'];
                                  String stockQuantity;
                                  return FlatButton(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  child: Container(
                                                    child: Image.network(
                                                      image,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: FittedBox(
                                              child: Text(
                                                brand,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 8, bottom: 15),
                                            child: FittedBox(
                                              child: Text(
                                                price,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      print(listViewDataWeekly);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                  title,
                                                  image,
                                                  price,
                                                  brand,
                                                  description,
                                                  condition,
                                                  idOne,
                                                  productId,
                                                  slug)));
                                    },
                                  );
                                },
                                itemCount: listViewDataWeekly.length,
                              ),
                            ),
                    ],
                  ),
                ),
              );
            })));
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

      setState(() {
        categoryList = data["data"] as List;
      });
      print(categoryList[1]['brand']);

//      print(res.body);
      //categoryList = rest.map<CategoryHead>((json) => CategoryHead.fromJson(json)).toList();
    }
    return categoryList;
  }

  Future getWeeklyList() async {
    List<dynamic> weeklyList;
    var v = weeklyList;
    String url =
        "${GlobalConfiguration().getString("base_uri")}/weekly_popular";
    print(url);
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//    print(res.body);
    print(res.statusCode.toString());
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      weeklyList = data["data"] as List;

//      print(res.body);
      //categoryList = rest.map<CategoryHead>((json) => CategoryHead.fromJson(json)).toList();
    }
    return weeklyList;
  }

  Future _getCategoryList() async {
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

class NewArrivalsModels {
  String image;
  NewArrivalsModels(this.image);
}
