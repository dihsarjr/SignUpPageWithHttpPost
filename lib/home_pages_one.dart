import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:registration/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageOne extends StatefulWidget {
  @override
  _HomePageOneState createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> {
  final List<NewArrivalsModels> newArrivals = [
    NewArrivalsModels(
      'https://images.unsplash.com/photo-1591375372509-68d11e1390df?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
    ),
    NewArrivalsModels(
        'https://images.unsplash.com/photo-1542406915-20eac16493d2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    NewArrivalsModels(
        'https://images.unsplash.com/photo-1502185635613-0a5b2e78efea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    NewArrivalsModels(
        'https://images.unsplash.com/photo-1546304696-bc6099d9e346?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    NewArrivalsModels(
        'https://images.unsplash.com/photo-1585565804112-f201f68c48b4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    NewArrivalsModels(
        'https://images.unsplash.com/photo-1556740714-a8395b3bf30f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
    NewArrivalsModels(
      'https://images.unsplash.com/photo-1591375372509-68d11e1390df?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
    ),
  ];

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
    Widget imageCarousel = Container(
      height: 250,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          NetworkImage(newArrivals[0].image),
          NetworkImage(newArrivals[1].image),
          NetworkImage(newArrivals[2].image),
          NetworkImage(newArrivals[3].image),
          NetworkImage(newArrivals[4].image),
          NetworkImage(newArrivals[5].image),
        ],
        autoplay: true,
        indicatorBgPadding: 1,
        dotColor: Color(0xFFee9ca7),
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
      ),
    );
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFEDA89D),
              title: Text('welcome'),
            ),
            drawer: Drawers(_emails, _passs),
            body: Column(
              children: <Widget>[imageCarousel],
            )));
  }
}

class NewArrivalsModels {
  String image;
  NewArrivalsModels(this.image);
}
