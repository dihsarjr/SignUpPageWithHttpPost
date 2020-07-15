import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
  bool favorite = false;

  DetailsPage(this.title, this.image, this.price, this.brand, this.description,
      this.condition, this.idOne, this.productId);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int numberOfItem = 1;
  String userId = '';

  List listData = [];

  @override
  void initState() {
    super.initState();
    _loadCounter();
    _validation1();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('id') ?? '');
      print(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brand),
        backgroundColor: Color(0xFFEDA89D),
        elevation: 0,
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                  icon: Icon(Icons.favorite_border), onPressed: () {})),
          Container(
              margin: EdgeInsets.only(right: 10),
              child:
                  IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}))
        ],
      ),
      body: Container(
        color: Color(0xFFEDA89D),
        padding: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
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
                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Color(0xFFEDA89D),
                                  ),
                                  //todo on press for the remove item
                                  onPressed: () {
                                    setState(() {
                                      numberOfItem--;
                                      print(numberOfItem);
                                    });
                                  }),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEDA89D),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                width: 30,
                                height: 30,
                                child: Center(
                                  child: Text(
                                    numberOfItem.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Color(0xFFEDA89D),
                                  ),
                                  //todo on press for the add item
                                  onPressed: () {
                                    setState(() {
                                      numberOfItem++;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontFamily: 'Muli',
                                fontSize: 30,
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
                            '${widget.price}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 400,
                            child: Divider(
                              color: Color(0xFFEDA89D),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              'Condition: ${widget.condition}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: Text(
                            'Description:\n'
                            '\n${widget.description}',
                          ),
                        ),
                      ],
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
                                color: Color(0xFFEDA89D),
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
                                color: Color(0xFFEDA89D),
                                size: 30,
                              ),
                              onPressed: () {
                                _validation();
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
                            top: 10, bottom: 10, right: 30, left: 30),
                        color: Color(0xFFEDA89D),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, right: 120, left: 120),
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
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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

  _validation1() async {
    Map<String, String> headers = {};
    Response response = await get(
      'http://multi.capcee.com/api/my_wishlist?user_id=31',
    );
    print('Response status: ${response.statusCode}');
    print(response);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();
    print(response.body);
    print(responseJson["data"][1]['id']);

    listData = responseJson['data'];
    print(listData[0]['id']);
    int counter = 0;
    bool ids = true;
    while (ids) {
      counter++;
      print(listData[counter]['id']);

      if (listData[counter]['product_id'].toString() == widget.productId) {
        ids = false;
        setState(() {
          widget.favorite = true;
        });
      }
    }
  }

  _validation12() async {
    Map<String, String> headers = {};
    Response response = await get(
      'http://multi.capcee.com/api/my_wishlist?user_id=31',
    );
    print('Response status: ${response.statusCode}');
    print(response);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();
    print(response.body);
    print(responseJson["data"][1]['id']);

    listData = responseJson['data'];
    print(listData[0]['id']);
    int counter = 0;
    bool ids = true;
    while (ids) {
      counter++;
      print(listData[counter]['id']);

      if (listData[counter]['product_id'].toString() == widget.productId) {
        ids = false;
        setState(() {
          widget.favorite = true;
        });
      }
    }
  }
}
