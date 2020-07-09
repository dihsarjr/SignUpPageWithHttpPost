import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  String response;
  Login(this.response);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Container(
          child: Text(
            response,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    ));
  }
}
