import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  String title;
  String image;
  String price;
  String brand;
  String description;
  String condition;
  DetailsPage(this.title, this.image, this.price, this.brand, this.description,
      this.condition);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int numberOfItem = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.brand),
      ),
      drawer: Drawer(),
      body: Container(
        color: Colors.purple,
        padding: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  //TODO back arrow button
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                widget.brand,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 200,
                            height: 200,
                            child: Image.network(widget.image),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontFamily: 'Muli',
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            widget.brand,
                            style: TextStyle(fontFamily: 'Muli'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            '${widget.price}',
                            style: TextStyle(fontFamily: 'Muli'),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 350,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.grey,
                                  ),
                                  //todo on press for the remove item
                                  onPressed: () {}),
                              Text(
                                '1',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.grey,
                                  ),
                                  //todo on press for the add item
                                  onPressed: () {}),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox.fromSize(
                              size: Size(56, 56), // button width and height
                              child: ClipOval(
                                child: Material(
                                  color: Color(0xFFEDA89D), // button color
                                  child: InkWell(
                                    splashColor: Colors.black12,
                                    //TODO on press for the cart button in Detailed view
                                    onTap: () {
                                      print('cart icon pressed');
                                    }, // button pressed
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                        ), // icon
                                        // text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              widget.condition,
                              style:
                                  TextStyle(fontFamily: 'Muli', fontSize: 20),
                            )),
                        Text(
                          widget.description,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
