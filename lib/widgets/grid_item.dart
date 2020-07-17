import 'package:flutter/material.dart';
import 'package:registration/full_detailed_view.dart';

class GridProducts extends StatelessWidget {
  String id;
  String title;
  String image;

  String brand;

  String productId;

  String condition;

  String description;

  String idOne;

  String price;
  GridProducts(this.id, this.title, this.image);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => DetailsPage(title, image, price, brand,
                      description, condition, idOne, productId)));
            },
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            trailing:
                IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}
