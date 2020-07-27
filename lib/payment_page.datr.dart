import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:registration/my_orders.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
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
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      child: Container(
                        child: FittedBox(
                          child: Text(
                            'Select payment method',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 25, left: 25, bottom: 10),
                      child: Divider(
                        color: Color(0xFF7550ff),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width * .70,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () {},
                            color: Color(0xFF7550ff),
                            textColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.credit_card),
                                ),
                                SizedBox(
                                  width: 20,
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
                          width: MediaQuery.of(context).size.width * .70,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () {},
                            color: Color(0xFF7550ff),
                            textColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.payment),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Bank transfer',
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
                          width: MediaQuery.of(context).size.width * .70,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              _validation();
                            },
                            color: Color(0xFF7550ff),
                            textColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.monetization_on),
                                ),
                                SizedBox(
                                  width: 20,
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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (c) => MyOrders(widget.userId)));
      });
    } else {}
  }
}
