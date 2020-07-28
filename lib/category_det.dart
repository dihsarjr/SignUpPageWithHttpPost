import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration/products.dart';

class CategoryDet extends StatelessWidget {
  List<dynamic> listViews;

  String titles;

  CategoryDet(this.listViews, this.titles);
  @override
  Widget build(BuildContext context) {
    print(listViews);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            titles,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (1 / 1),
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            itemBuilder: (ctx, index) {
              String id = listViews[index]['id'].toString();
              return FlatButton(
                padding: EdgeInsets.all(0),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          child: Image.network(
                            listViews[index]['img'],
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
                            listViews[index]['name'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: FittedBox(
                          child: Text(
                            listViews[index]['description'],
                            style: TextStyle(
                                color: Colors.grey,
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
                          builder: (context) => ProductsPage(id)));
                },
              );
            },
            itemCount: listViews.length,
          ),
        ));
//    return ListView.builder(
//      itemBuilder: (context, index) {
//        return ListTile(
//          title: Text('n'),
//        );
//      },
//      itemCount: listViews.length,
//    );
  }
}
