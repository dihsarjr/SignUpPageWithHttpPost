import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration/products.dart';

class CategoryDet extends StatelessWidget {
  List<dynamic> listViews;

  CategoryDet(this.listViews);
  @override
  Widget build(BuildContext context) {
    print(listViews[0]['id']);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFEDA89D),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (1 / 1.2),
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            itemBuilder: (ctx, index) {
              String id = listViews[index]['id'].toString();
              return FlatButton(
                padding: EdgeInsets.all(0),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xFFEDA89D),
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
                            listViews[index]['description'],
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
