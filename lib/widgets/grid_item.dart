import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:registration/address_page.dart';

class GridProducts extends StatefulWidget {
  String id;
  String title;
  String image;

  String userId;
  String emails;
  String inventoryId;
  String cartId;
  String shopId;
  String shipTo;
  String titl;
  Future<dynamic> validation;

  GridProducts(
      this.id,
      this.title,
      this.image,
      this.shopId,
      this.shipTo,
      this.cartId,
      this.userId,
      this.emails,
      this.inventoryId,
      this.validation,
      this.titl);

  @override
  _GridProductsState createState() => _GridProductsState();
}

class _GridProductsState extends State<GridProducts> {
  String brand;

  String productId;

  String condition;

  String description;

  String idOne;

  String price = '\$${100}';

  String inventory;

  bool page = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressPage(
                                email: widget.emails,
                                userId: widget.userId,
                                shopId: widget.shopId,
                                cartId: widget.cartId,
                                shipTo: widget.shipTo,
                              )));
                },
                child: Container(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.title,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            widget.titl,
                            style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Text(
                        price,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black12,
                      ),
                      onPressed: () {
                        setState(() {
                          _validation1(widget.cartId, widget.inventoryId);
                        });
                      }),
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.black12,
                          ),
                          onPressed: () {}),
                      Text('1'),
                      IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.black12,
                          ),
                          onPressed: () {}),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _validation1(String cart, String item) async {
    Map<String, String> headers = {};
    Response response = await get(
      'http://multi.capcee.com/api/cart/removeItem?cart=$cart&item=$item',
    );
    print('Response status: ${response.statusCode}');
    print(response);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();
    print(response.body);
    print(responseJson["data"][1]['id']);
  }
}
