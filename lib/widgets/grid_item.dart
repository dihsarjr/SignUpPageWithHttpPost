import 'package:flutter/material.dart';

import '../address_page.dart';

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
  String inventory;

  String userId;
  String emails;

  String cartId;
  String shopId;
  String shipTo;
  GridProducts(this.id, this.title, this.image, this.shopId, this.shipTo,
      this.cartId, this.userId, this.emails);
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddressPage(
                            shipTo: shipTo,
                            cartId: cartId,
                            shopId: shopId,
                            userId: userId,
                            email: emails,
                          )));
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
