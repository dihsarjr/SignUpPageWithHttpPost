import 'package:flutter/material.dart';
import 'package:registration/category_det.dart';

class CategoryList extends StatelessWidget {
  List listv;

  CategoryList(this.listv);
  @override
  Widget build(BuildContext context) {
    print(listv);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1 / 0.8),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, index) {
            return FlatButton(
              padding: EdgeInsets.all(0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        child: Image.network(
                          listv[index]["categorygroup"]["img"],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          listv[index]["categorygroup"]["name"],
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
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
                        builder: (context) => CategoryDet(
                            listv[index]["categorygroup"]["category_sub_group"],
                            listv[index]["categorygroup"]["name"])));
              },
            );
          },
          itemCount: listv.length,
        ),
      ),
    );
  }
}
