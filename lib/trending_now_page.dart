import 'package:flutter/material.dart';
import 'package:registration/widgets/trending_now.dart';

class TrendingNowPage extends StatelessWidget {
  List listViewData;
  TrendingNowPage(this.listViewData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Now'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1.02 / 1),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return TrendingNow(
              listViewData[index]['image'],
              listViewData[index]['title'],
              listViewData[index]['sale_price'],
              listViewData[index]['brand'],
            );
          },
          itemCount: listViewData.length,
        ),
      ),
    );
  }
}
