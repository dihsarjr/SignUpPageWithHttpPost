import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../address_page.dart';

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
  Future<dynamic> validation;

  GridProducts(this.id, this.title, this.image, this.shopId, this.shipTo,
      this.cartId, this.userId, this.emails, this.inventoryId, this.validation);

  @override
  _GridProductsState createState() => _GridProductsState();
}

class _GridProductsState extends State<GridProducts> {
  String brand;

  String productId;

  String condition;

  String description;

  String idOne;

  String price;

  String inventory;

  bool page = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddressPage(
                            shipTo: widget.shipTo,
                            cartId: widget.cartId,
                            shopId: widget.shopId,
                            userId: widget.userId,
                            email: widget.emails,
                          )));
            },
            child: Image.network(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            title: Text(
              widget.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _validation1(widget.cartId, widget.inventoryId);
                  setState(() {
                    // ignore: unnecessary_statements
                    widget.validation;
                  });
                }),
            backgroundColor: Colors.black54,
          ),
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
