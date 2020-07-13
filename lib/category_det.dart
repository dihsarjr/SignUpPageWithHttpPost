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
        appBar: AppBar(),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1 / 1),
          ),
          itemBuilder: (ctx, index) {
            String id = listViews[index]['id'].toString();
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
                          image: NetworkImage(listViews[index]["img"]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          listViews[index]['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          listViews[index]['description'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductsPage(id)));
              },
            );
          },
          itemCount: listViews.length,
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
