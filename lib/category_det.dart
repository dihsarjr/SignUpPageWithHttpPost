import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDet extends StatelessWidget {
  List listViews;
  CategoryDet(this.listViews);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: listViews[index]["categorygroup"]["category_sub_group"],
        );
      },
      itemCount: listViews.length,
    );
  }
}
