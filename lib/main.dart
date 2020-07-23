import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';
import 'package:registration/home_pages_one.dart';
import 'package:registration/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      _passs = (prefs.getString('password') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: IconThemeData(color: Colors.black)),
      home: _emails != '' ? HomePageOne() : Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _email = '';
  String _pass = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  String subscribe = '1';

  String _firstName;
  String _lastName;
  String _mail;
  String _password;

  final formKeySignUp = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  void _submit() {
    setState(() {
      if (formKeySignUp.currentState.validate()) {
        formKeySignUp.currentState.save();
        _loadCounter();
        addStringToSF();
        print(emailController);
        print(passwordController);
        _validation(
          nameController.text,
          emailController.text,
          passwordController.text,
        );
      }
    });
  }

  addStringToSF() async {
    String names = nameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', names);
    prefs.setString('lastName', lastName);
    prefs.setString('email', email);
    prefs.setString('password', password);

    print(names);
    print(lastName);
    print(email);
    print(password);
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('email') ?? '');
      _pass = (prefs.getString('password') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeySignUp,
      child: SafeArea(
        child: Scaffold(
          key: _globalKey,
          body: Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "First Name"),
                    validator: (val) =>
                        val.length < 2 ? 'Need Minimum 2 Characters' : null,
                    onSaved: (val) => _firstName = val,
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Last Name"),
                    validator: (val) =>
                        val.length < 2 ? 'Need Minimum 2 Characters' : null,
                    onSaved: (val) => _lastName = val,
                    controller: lastNameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Email"),
                    validator: (val) => !val.contains('@') && !val.contains('.')
                        ? 'Invalid Email'
                        : null,
                    onSaved: (val) => _mail = val,
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Password"),
                    validator: (val) =>
                        val.length < 6 ? 'Password too short' : null,
                    onSaved: (val) => _password = val,
                    controller: passwordController,
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    onPressed: () {
                      _showSnackBar('Register Successfully');
                      _submit();
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      color: Colors.black87,
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF3d60ff), Color(0xFF7550ff)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: FittedBox(
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          padding: EdgeInsets.all(0),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validation(
    String name,
    String email,
    String password,
  ) async {
    Map<String, String> headers = {};
    Response response = await post('http://multi.capcee.com/api/register',
        headers: headers,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'subscribe': '1',
        });
    print('Response status: ${response.statusCode}');
    print(response.body);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();

    print(responses);
    if (responses == 'true') {
      _showSnackBar(responses);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  _showSnackBar(String text) {
    return _globalKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: 3),
    ));
  }
}
