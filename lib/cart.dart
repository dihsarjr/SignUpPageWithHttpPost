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
      _validation1(userId);
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
                  'Loading',
                  style: TextStyle(fontSize: 25),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1.04),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (ctx, index) {
                  return GridProducts(listData[index]['id'].toString(),
                      listData[index]['brand'], listData[index]['image']);
                },
                itemCount: listData.length,
              ),
      ),
    );
  }

  _validation1(String id) async {
    Map<String, String> headers = {};
    Response response = await get(
      'http://multi.capcee.com/api/my_wishlist?user_id=$id',
    );
    print('Response status: ${response.statusCode}');
    print(response);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();
    print(response.body);
    print(responseJson["data"][1]['id']);
    setState(() {
      listData = responseJson['data'];
    });

    print(listData[0]['id']);
  }
}
