import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:registration/cart.dart';
import 'package:registration/wish_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsPage extends StatefulWidget {
  String title;
  String image;
  String price;
  String brand;

  String description;
  String condition;
  String idOne;
  String productId;
  String inventory;
  bool favorite = false;

  bool button = true;

  DetailsPage(this.title, this.image, this.price, this.brand, this.description,
      this.condition, this.idOne, this.productId, this.inventory);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int numberOfItem = 1;
  String userId;
  bool connection;

  List listData = [];

  @override
  void initState() {
    _checkInternetConnectivity();
    super.initState();

    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('id') ?? '');
      print(userId);
      _validation1(userId);
    });
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        connection = true;
      });
    } else {
      connection = false;
    }
  }

  _showSnackBar(String text) {
    return _globalKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: 3),
    ));
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text(
          widget.brand,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WishList()));
                  })),
          Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                  }))
        ],
      ),
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(0),
          child: connection == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      margin: EdgeInsets.all(10),
                      child: Center(
                        child: ClipRRect(
                          child: Image.network(
                            widget.image,
                            height: 400,
                            width: 400,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 15, right: 15),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
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
                                            child: IconButton(
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.black,
                                                ),
                                                //todo on press for the remove item

                                                onPressed: () {
                                                  numberOfItem == 0
                                                      ? print('object')
                                                      : setState(() {
                                                          numberOfItem--;
                                                          print(numberOfItem);
                                                        });
                                                }),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                numberOfItem.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30),
                                              ),
                                            ),
                                          ),
                                          Container(
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
                                            child: IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                ),
                                                //todo on press for the add item
                                                onPressed: () {
                                                  setState(() {
                                                    numberOfItem++;
                                                  });
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: Text(
                                      widget.title,
                                      style: TextStyle(
                                          fontFamily: 'Muli',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: Text(
                                      widget.brand,
                                      style: TextStyle(fontFamily: 'Muli'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: Text(
                                      '\$: ${widget.price}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      child: Text(
                                        'In Stock',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: 400,
                                      child: Divider(
                                        color: Color(0xFF7550ff),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 4, bottom: 5),
                                      child: widget.condition == null
                                          ? Text(
                                              'Condition: New',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )
                                          : Text(
                                              'Condition: ${widget.condition}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      'About this item',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: widget.description == null
                                        ? Text(
                                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised  the release of Letraset sheets containing Lorem Ipsum passages and more recently  desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'
                                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'
                                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                                            style: TextStyle(
                                                color: Colors.black38),
                                          )
                                        : Text(
                                            'Description:\n'
                                            '\n${widget.description}',
                                            style: TextStyle(
                                                color: Colors.black38),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      elevation: 20,
                      margin: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          widget.favorite == false
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Color(0xFF7550ff),
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        _validation();
                                        setState(() {
                                          widget.favorite = true;
                                        });
                                      }),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Color(0xFF7550ff),
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _validation12(widget.idOne);
                                          print(widget.idOne);
                                        });
                                      }),
                                ),
                          Column(
                            children: <Widget>[
                              Card(
                                elevation: 9,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 10, right: 20, left: 20),
                                color: Color(0xFFEDA89D),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF3d60ff),
                                          Color(0xFF7550ff)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 52, left: 52),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          _validation2();
                                          print('123');
                                          setState(() {
                                            widget.button = false;
                                            _showSnackBar('Added');
                                          });
                                        },
                                        child: Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'No Internet Connection',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(Icons.refresh),
                              onPressed: () {
                                _checkInternetConnectivity();
                              }),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }

  _validation() async {
    Map<String, String> headers = {};
    Response response = await post('http://multi.capcee.com/api/add_wishlist',
        headers: headers,
        body: {
          'id': widget.idOne,
          'product_id': widget.productId,
          'user_id': userId
        });
    print('Response status: ${response.statusCode}');
    print(response.body);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();
    print(responses);
  }

  _validation2() async {
    Map<String, String> headers = {};
    Response response = await post('http://multi.capcee.com/api/addToCart',
        headers: headers,
        body: {
          'shipTo': '356',
          'shippingZoneId': '',
          'shippingRateId': '',
          'quantity': '1',
          'inventory_id': widget.inventory,
          'user_id': userId,
        });
    print('Response status: ${response.statusCode}');

    print(response.body);

    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();

    if (responses == 'item added to cart.') {
      print('Dome');
    } else {
      print('no no no');
    }

    print(responses);
  }

  _validation1(String id) async {
    Map<String, String> headers = {};
    Response response = await get(
      'http://multi.capcee.com/api/my_wishlist?user_id=$id',
    );
    print('Response status: ${response.statusCode}');
    print(response);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();
    print(response.body);
    print(responseJson["data"][1]['id']);
    setState(() {
      listData = responseJson['data'];
    });

    print(listData[0]['id']);
    int counter = 0;
    bool ids = true;
    while (ids) {
      counter++;
      print(listData[counter]['id']);

      if (listData[counter]['id'].toString() == widget.idOne) {
        ids = false;
        setState(() {
          widget.favorite = true;
        });
      } else if (counter == listData.length - 1) {
        ids = false;
      }
    }
  }

  _validation12(String id1) async {
    Map<String, String> headers = {};

    Response response = await get(
      'http://multi.capcee.com/api/remove_wishlist?id=$id1',
      headers: headers,
    );
    print('Response status: ${response.statusCode}');
    print(response);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();
    print(response.body);
    setState(() {
      widget.favorite = false;
    });
  }
}
