import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:registration/full_detailed_view.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFFEDA89D),
          title: Text('Products'),
        ),
        body: productsList['data'] == null
            ? Center(
                child: Text(
                  'Loading',
                  style: TextStyle(fontSize: 30),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (1 / 1.1),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (ctx, index) {
                    String title = productsList['data'][index]['title'];
                    String image = productsList['data'][index]['image'];
                    String brand = productsList['data'][index]['brand'];
                    String condition = productsList['data'][index]['condition'];
                    String idOne = productsList['data'][index]['id'].toString();
                    String productId =
                        productsList['data'][index]['product_id'].toString();
                    String conditionNote;
                    String description =
                        productsList['data'][index]['description'];
                    String price =
                        'price :${productsList['data'][index]['sale_price']}';
                    String slug = productsList['data'][index]['inventory_id'];
                    String stockQuantity;
                    return FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Color(0xFFEDA89D),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: ClipRRect(
                                child: Image.network(
                                  image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Text(
                                  brand,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                    title,
                                    image,
                                    price,
                                    brand,
                                    description,
                                    condition,
                                    idOne,
                                    productId,
                                    slug)));
                      },
                    );
                  },
                  itemCount: productsList['data'].length,
                ),
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
        print(productsList['data'][0]['inventory_id'].toString());
      });
    } else {}
  }
}
