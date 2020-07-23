import 'package:flutter/material.dart';
import 'package:registration/widgets/trending_now.dart';

class TrendingNowPage extends StatelessWidget {
  List listViewData;
  TrendingNowPage(this.listViewData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Trending Now',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1 / 1),
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
          ),
          itemBuilder: (context, index) {
            return TrendingNow(
                listViewData[index]['image'],
                listViewData[index]['title'],
                listViewData[index]['sale_price'],
                listViewData[index]['brand'],
                listViewData[index]['id'].toString(),
                listViewData[index]['inventory_id']);
          },
          itemCount: listViewData.length,
        ),
      ),
    );
  }
}
