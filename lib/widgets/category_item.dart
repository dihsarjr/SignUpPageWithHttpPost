import 'package:flutter/material.dart';
import 'package:registration/products.dart';

class CategoryModel extends StatelessWidget {
  String title;
  String image;
  String id;
  CategoryModel(this.image, this.title, this.id);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductsPage(id)));
      },
      child: GridTile(
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
