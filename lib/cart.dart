import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:registration/widgets/grid_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List listData;
  String shipto;
  String userId;
  String emails;

  String cartId;
  String inventoryId;
  String shopId;
  String shipTo;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('id') ?? '');
      emails = (prefs.getString('email') ?? '');
      print(userId);
      print(emails);
      _validation(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: listData == null
            ? Center(
                child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
              ))
            : Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          cartId =
                              listData[index]['pivot']['cart_id'].toString();
                          inventoryId = listData[index]['pivot']['inventory_id']
                              .toString();
                          shipTo = shipto;
                          shopId = listData[index]['shop_id'].toString();
                          print(cartId);
                          print('ship to $shipTo');
                          print(shopId);
                          return GridProducts(
                            listData[index]['brand'],
                            listData[index]['brand'],
                            listData[index]['image'],
                            shopId,
                            shipTo,
                            cartId,
                            userId,
                            emails,
                            inventoryId,
                            _validation(userId),
                            listData[index]['title'],
                          );
                        },
                        itemCount: listData.length,
                      ),
                    ),
                  ),
//                  Container(
//                      width: 300,
//                      height: 50,
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(30.0),
//                        ),
//                        onPressed: () {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => AddressPage(
//                                        email: emails,
//                                        userId: userId,
//                                        shopId: shopId,
//                                        cartId: cartId,
//                                        shipTo: shipTo,
//                                      )));
//                        },
//                        color: Color(0xFFEDA89D),
//                        textColor: Colors.white,
//                        child: Text("Check Out".toUpperCase(),
//                            style: TextStyle(fontSize: 14)),
//                      )),
                ],
              ),
      ),
    );
  }

  _validation(
    String name,
  ) async {
    Map<String, String> headers = {};
    Response response = await post('http://multi.capcee.com/api/carts',
        headers: headers,
        body: {
          'user_id': name,
        });
    print('Response status: ${response.statusCode}');
    print(response.body);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['data'].toString();
    setState(() {
      listData = responseJson['data'][0]['items'];
      shipto = responseJson['data'][0]['ship_to'].toString();
      print(responseJson['data'][0]['ship_to']);
//      print(responseJson['data'][1]['items'][0]['pivot']['cart_id']);
//      print(responseJson['data'][1]['ship_to']);
    });
//
//    print(responses);
//    print(
//      listData[0]['items'][0]['brand'],
//    );
  }
}
