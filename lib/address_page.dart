import 'package:flutter/material.dart';
import 'package:registration/add_address.dart';
import 'package:registration/payment_page.datr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends StatefulWidget {
  String name = '';
  String house;
  String city;
  String state;

  bool page = false;

  String cartId;
  String shopId;
  String userId;
  String email;
  String shipTo;

  AddressPage({this.email, this.userId, this.cartId, this.shipTo, this.shopId});

//
//  prefs.setString('name', name);
//  prefs.setString('address', address);
//  prefs.setString('city', city);
//  prefs.setString('state', state);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.name = (prefs.getString('name') ?? '');
      widget.house = (prefs.getString('address') ?? '');
      widget.city = (prefs.getString('city') ?? '');
      widget.state = (prefs.getString('state') ?? '');
      print(widget.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Address',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: widget.name == ''
          ? Center(
              child: Text('Add Your Address'),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                    cartId: widget.cartId,
                                    email: widget.email,
                                    shipTo: widget.shipTo,
                                    shopId: widget.shopId,
                                    userId: widget.userId,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              offset: Offset(-6.0, -6.0),
                              blurRadius: 16.0,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(6.0, 6.0),
                              blurRadius: 16.0,
                            ),
                          ],
                          color: Color(0xFF7550ff),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    'Name : ${widget.name}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    'Address : ${widget.house}, ${widget.city},  ${widget.state}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white54),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 1,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF7550ff),
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddAddress()))
              .then((value) {
            setState(() {
              widget.page = value;
            });

            if (widget.page == true) {
              setState(() {
                _loadCounter();
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
