import 'package:flutter/material.dart';
import 'package:registration/add_address.dart';

class AddressPage extends StatefulWidget {
  String name;
  String address;
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        backgroundColor: Color(0xFFEDA89D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                height: 200,
                child: Card(
                  color: Color(0xFFEDA89D),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          child: Text(
                            'Name : ${widget.name}',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            'Address : ${widget.address}',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: 2,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFEDA89D),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddAddress()));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
