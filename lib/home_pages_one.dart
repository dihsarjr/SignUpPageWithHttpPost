import 'package:flutter/material.dart';
import 'package:registration/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class HomePageOne extends StatefulWidget {
  @override
  _HomePageOneState createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> {
  String _emails = '';

  String _passs = '';

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emails = (prefs.getString('email') ?? '');
      _passs = (prefs.getString('name') ?? '');
    });
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("email");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('welcome'),
            ),
            drawer: Drawers(_emails, _passs),
            body: Center(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome  $_passs',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  RaisedButton(
                      child: Text('LogOut'),
                      onPressed: () {
                        removeValues();

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      })
                ],
              ),
            ))));
  }
}
