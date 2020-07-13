import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Container(child: RaisedButton(
        onPressed: () {
          _validation();
        },
      )),
    );
  }

  _validation() async {
    Map<String, String> headers = {};
    Response response = await post(
        'http://multi.capcee.com/api/category_product',
        headers: headers,
        body: {
          'category_id': '6',
        });
    print('Response status: ${response.statusCode}');
    print(response.body);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();

    print(responses);
  }
}
