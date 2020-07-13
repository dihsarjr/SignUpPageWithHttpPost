import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductsPage extends StatefulWidget {
  String idProduct;
  ProductsPage(this.idProduct);
  @override
  _ProductsPageState createState() => _ProductsPageState(idProduct);
}

class _ProductsPageState extends State<ProductsPage> {
  Map<String, dynamic> productsList = {};
  String idProduct;
  _ProductsPageState(this.idProduct);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _validation();
  }

////GET DATA FROM FUTURE FUNCTION
//  getData() async {
//    await _validation().then((v) {
//      v != null
//          ? setState(() {
//              productsList = v;
//            })
//          : setState(() {
//              productsList = null;
//            });
//    });
//  }

  @override
  Widget build(BuildContext context) {
//    print(productsList);
    return Scaffold(
        appBar: AppBar(
          title: Text('data'),
        ),
        body: productsList['data'] == null
            ? Center(
                child: Text(
                  'Loading',
                  style: TextStyle(fontSize: 30),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1),
                ),
                itemBuilder: (ctx, index) {
                  return FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Card(
                      color: Colors.yellow,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    productsList['data'][index]['image']),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                productsList['data'][index]['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                'price :${productsList['data'][index]['sale_price']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => ProductsPage()));
                    },
                  );
                },
                itemCount: productsList['data'].length,
              ));
  }

  _validation() async {
    Map<String, String> headers = {};
    Response response = await post(
        'http://multi.capcee.com/api/category_product',
        headers: headers,
        body: {
          'category_id': idProduct,
        });
    print('Response status: ${response.statusCode}');
//    print(response.body);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    String responses = responseJson['message'].toString();
//    print(responseJson);
    if (responses != '') {
      setState(() {
        productsList = responseJson;
//        print(productsList);
        print(productsList['data'][0]['title']);
      });
    } else {}
  }
}
