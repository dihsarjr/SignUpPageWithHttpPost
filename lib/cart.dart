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

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('id') ?? '');
      print(userId);
      _validation(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: listData == null
            ? Center(
                child: Text(
                  'Empty',
                  style: TextStyle(fontSize: 25),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1.5),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (ctx, index) {
                  return GridProducts(
                    listData[index]['items'][0]['brand'],
                    listData[index]['items'][0]['brand'],
                    listData[index]['items'][0]['image'],
                  );
                },
                itemCount: listData.length,
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
      print(listData);
    });
//
//    print(responses);
//    print(
//      listData[0]['items'][0]['brand'],
//    );
  }
}
