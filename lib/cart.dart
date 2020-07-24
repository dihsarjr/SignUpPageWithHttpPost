import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:registration/widgets/grid_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'address_page.dart';

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
  bool check = false;

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
    print(listData);
    int price = 120;
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: check == false
            ? Center(
                child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
              ))
            : listData == null
                ? Center(
                    child: Text('empty'),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${listData.length} Item available',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              cartId = listData[index]['pivot']['cart_id']
                                  .toString();
                              inventoryId = listData[index]['pivot']
                                      ['inventory_id']
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
                                  price.toString());
                            },
                            itemCount: listData.length,
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5, top: 10, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Total :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    '\$${price * listData.length}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Divider(
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, bottom: 5, right: 20, top: 10),
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddressPage(
                                                email: emails,
                                                userId: userId,
                                                shopId: shopId,
                                                cartId: cartId,
                                                shipTo: shipTo,
                                              )));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  color: Colors.black87,
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
                                            BorderRadius.circular(40.0)),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Checkout',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
    if (response.statusCode == 200) {
      setState(() {
        check = true;
      });
    } else {}
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
