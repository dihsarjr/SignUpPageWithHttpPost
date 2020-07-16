import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
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
    return Container();
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

    listData = responseJson['data'];
    print(listData[0]['id']);
  }
}
