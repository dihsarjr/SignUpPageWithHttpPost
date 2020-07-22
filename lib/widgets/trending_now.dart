import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../full_detailed_view.dart';

class TrendingNow extends StatelessWidget {
  String image;
  String title;
  String price;
  String brand;
  String description;
  String condition;
  String idOne;
  String productId;
  String inventory;
  TrendingNow(this.image, this.title, this.price, this.brand, this.idOne,
      this.inventory);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(title, image, price, brand,
                    description, condition, idOne, productId, inventory)));
      },
      padding: EdgeInsets.all(0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.white,
        child: Container(
          height: 250,
          width: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    child: Image.network(
                      image == null
                          ? 'https://images.unsplash.com/photo-1593642634367-d91a135587b5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
                          : image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: FittedBox(
                  child: Text(
                    brand,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 15),
                child: FittedBox(
                  child: Text(
                    '\$ : ${price}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
