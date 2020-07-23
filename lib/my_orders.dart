import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyOrders extends StatefulWidget {
  List data;
  String userIds;
  MyOrders(this.userIds);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    _validation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: widget.data == null
            ? Center(
                child: Container(
                  child: Text('Empty'),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1 / 1),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GridTile(
                      child: GestureDetector(
                        onTap: () {},
                        child: Image.network(
                          widget.data[index]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      footer: GridTileBar(
                        title: Text(
                          widget.data[index]['title'],
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.black54,
                      ),
                    ),
                  );
                },
                itemCount: widget.data.length,
              ),
      ),
    );
  }

  _validation() async {
    Map<String, String> headers = {};
    Response response = await post('http://multi.capcee.com/api/orders',
        headers: headers,
        body: {
          'user_id': widget.userIds,
        });

    print('Response status: ${response.statusCode}');
    print(response.body);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();

    print(responseJson['data'][0]['inventories']);
    setState(() {
      widget.data = responseJson['data'][0]['inventories'];
    });

    print(responseJson['data'][0]['inventories'][1]);
  }
}
