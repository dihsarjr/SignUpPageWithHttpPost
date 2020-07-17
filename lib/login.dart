import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_pages_one.dart';
import 'main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _mail = '';

  String _pass = '';

  String emailCont = '';

  String passCont = '';

  String passError = '';

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();

  String _email;

  String _password;

  Map data;

  void _submit() {
    setState(() {
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        emailCont = emailController.text;
        passCont = passwordController.text;

        print(emailCont);
        print(passCont);
        print(_mail);
        print(_pass);
        if (emailCont == _mail && passCont == _pass) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePageOne()));
        } else {
          passError = 'invalid email and password';
        }
      } else {
        passError = 'invalid email and password';
      }
    });
  }
//
//  @override
//  void initState() {
//    super.initState();
//    _loadCounter();
//  }
//
//  _loadCounter() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    setState(() {
//      _mail = (prefs.getString('email') ?? '');
//      _pass = (prefs.getString('password') ?? '');
//    });
//  }

  addStringToSF(String id) async {
    String email = emailController.text;
    String password = passwordController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('id', id);

    print(email);
    print(password);
    print(id);
  }

  bool loginStatus = false;
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    'Welcome,',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Sign In to continue',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Email"),
                    validator: (String val) =>
                        !val.contains('@') && !val.contains('.')
                            ? 'Invalid Email'
                            : null,
                    onSaved: (String val) => _email = val,
                    controller: emailController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Password"),
                    validator: (val) =>
                        val.length < 6 ? 'Password too short' : null,
                    onSaved: (val) => _password = val,
                    controller: passwordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      onPressed: () {
                        progress = true;
                        _submit();
                        _validation(
                            emailController.text, passwordController.text);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        color: Colors.black87,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: progress != false
                              ? CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ),
                        )),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                        child: emailCont != _mail &&
                                passCont != _pass &&
                                _email == null
                            ? Text(
                                passError,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            : Container()),
                  ),
                  loginStatus == false
                      ? Container()
                      : Center(
                          child: Text(
                            'Invalid Password or Email',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _validation(
    String email,
    String password,
  ) async {
    Map<String, String> headers = {};
    Response response = await post('http://multi.capcee.com/api/login',
        headers: headers,
        body: {
          'email': email,
          'password': password,
        });

    print('Response status: ${response.statusCode}');
    print(response.body);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();

    print(responses);

    if (responseJson['response'] == 'true') {
      String id = responseJson['data']['id'].toString();
      addStringToSF(id);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePageOne()));
    } else {
      setState(() {
        progress = false;
        loginStatus = true;
      });
    }
  }
}
