import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final DocumentSnapshot product;
  final String appbartitle;
  DetailsPage({Key key, this.product, this.appbartitle}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  BuildContext context;
  int numberOfItems = 1;
  showsnackbar() {
    return Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        content: Text(
            "Order placed.  You have to pay Rs. ${(widget.product["price"]) * numberOfItems}")));
  }

  //AnimationController _animationController=AnimationController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () {
            showsnackbar();
            Firestore.instance.collection("Orders").add({
              "item": widget.product["title"],
              "quantity": numberOfItems,
            });
          },
          label: Text("Buy Now")),
      backgroundColor: Colors.green,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: Text(widget.appbartitle),
      ),
      body: Builder(builder: (context) {
        this.context = context;
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  //height: size.height,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: size.height * 0.01, left: size.width * 0.05),
                        margin: EdgeInsets.only(top: size.height * 0.3),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(25)),
                            color: Colors.white),
                        height: size.height * 0.66,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 32,
                                      width: 40,
                                      child: FlatButton(
                                        color: Colors.green,
                                        padding: EdgeInsets.all(5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        onPressed: () {
                                          setState(() {
                                            numberOfItems <= 0
                                                ? numberOfItems = 0
                                                : numberOfItems--;
                                          });
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text("$numberOfItems",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .copyWith(
                                                color: Colors.green[900],
                                                fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                      height: 32,
                                      width: 40,
                                      child: FlatButton(
                                        color: Colors.green,
                                        padding: EdgeInsets.all(5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        onPressed: () {
                                          setState(() {
                                            numberOfItems++;
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(height: 15),
                              Flexible(
                                  child: Text(widget.product["description"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              widget.product["title"],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: "Price\n"),
                                  TextSpan(
                                    text: "Rs." +
                                        widget.product["price"].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                  )
                                ])),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 8, color: Colors.green),
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(widget
                                              .product["image"]
                                              .toString()),
                                          fit: BoxFit.cover)),
                                  height: size.height * 0.25,
                                  width: size.width * 0.2,
                                )),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
