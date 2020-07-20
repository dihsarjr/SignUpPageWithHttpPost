import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddress extends StatelessWidget {
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController roadController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
        backgroundColor: Color(0xFFEDA89D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Add Your Address',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Pincode'),
                  controller: pinCodeController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration:
                      InputDecoration(labelText: 'House No, Building Name '),
                  controller: houseController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Road Name, Area, Colony'),
                  controller: roadController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 170,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'City'),
                          controller: cityController,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 215,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'State'),
                          controller: stateController,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Landmark (Optional)'),
                  controller: landmarkController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: nameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Mobile'),
                  controller: mobileController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                    width: 300,
                    height: 50,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        addStringToSF();
                        Navigator.of(context).pop(true);
                      },
                      color: Color(0xFFEDA89D),
                      textColor: Colors.white,
                      child: Text("Save".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  addStringToSF() async {
    String name = nameController.text;
    String address = houseController.text;
    String city = cityController.text;
    String state = stateController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', name);
    prefs.setString('address', address);
    prefs.setString('city', city);
    prefs.setString('state', state);

    print(name);
    print(address);
    print(city);
    print(state);
  }
}
