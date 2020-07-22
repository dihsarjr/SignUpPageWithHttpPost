import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PaymentPage extends StatefulWidget {
  String cartId;
  String shopId;
  String userId;
  String email;
  String shipTo;

  PaymentPage({this.email, this.userId, this.cartId, this.shipTo, this.shopId});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Color(0xFFEDA89D),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: status == true
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Order Placed',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Icon(
                        Icons.assignment_turned_in,
                        size: 40,
                      )
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          height: 45,
                          width: 300,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () {},
                            color: Color(0xFFEDA89D),
                            textColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.credit_card),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Credit Card',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          height: 45,
                          width: 300,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              _validation();
                            },
                            color: Color(0xFFEDA89D),
                            textColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.monetization_on),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Cash On Delivery',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }

  _validation() async {
    Map<String, String> headers = {};
    Response response = await post('http://multi.capcee.com/api/cart/checkout',
        headers: headers,
        body: {
          'cart_id': widget.cartId,
          'user_id': widget.userId.toString(),
          'shippingRateId': '',
          'packing_id': '1',
          'payment_method_id': '6',
          'shipping_option_id': '',
          'discount_id': '',
          'shop_id': widget.shopId,
          'zone_id': '',
          'coupon': '',
          'ship_to': widget.shipTo,
          'shipping_address': 'house (h), place P, malappuram (dt)',
          'email': widget.email,
          'buyer_note': '',
        });

    print('Response status: ${response.statusCode}');
    print(response.body);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();

    print(responses);
    if (response.statusCode == 201) {
      print('200');
      setState(() {
        status = true;
      });
    } else {}
  }
}
