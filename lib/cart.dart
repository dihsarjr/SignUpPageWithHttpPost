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
  String userId;
  String emails;

  String cartId;
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
        title: Text('Cart'),
        backgroundColor: Color(0xFFEDA89D),
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
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (1 / 1.5),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (ctx, index) {
                          cartId = listData[index]['items'][0]['pivot']
                                  ['cart_id']
                              .toString();
                          shipTo = listData[index]['ship_to'].toString();
                          shopId =
                              listData[index]['items'][0]['shop_id'].toString();
                          print(cartId);
                          print('ship to $shipTo');
                          print(shopId);
                          return GridProducts(
                              listData[index]['items'][0]['brand'],
                              listData[index]['items'][0]['brand'],
                              listData[index]['items'][0]['image'],
                              shopId,
                              shipTo,
                              cartId,
                              userId,
                              emails);
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
      listData = responseJson['data'];

//      print(responseJson['data'][1]['items'][0]['shop_id']);
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
