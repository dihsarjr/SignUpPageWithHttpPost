import 'package:flutter/material.dart';

class HomePageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          RaisedButton(child: Text('LogOut'), onPressed: () {})
        ],
      ),
    ))));
  }
}
