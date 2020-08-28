import 'package:WeCare/view/firstAid/pages/aiddetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BodyPage extends StatefulWidget {
  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  List<String> categories = ["Basic Supplies", "Medications", "Emergency Kit"];
  int selectedIndex = 0;
  int selected = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
          stream:
              Firestore.instance.collection(categories[selected]).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                semanticsLabel: "Loading...",
              ));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () => setState(() {
                                selectedIndex = index;
                                selected = index;
                                Products();
                              }),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Column(
                                  children: [
                                    Text(categories[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                    Container(
                                        margin: EdgeInsets.all(6),
                                        height: 2,
                                        width: 95,
                                        color: selectedIndex == index
                                            ? Colors.green
                                            : Colors.transparent),
                                  ],
                                ),
                              ),
                            )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GridView.builder(
                        itemCount: snapshot.data.documents.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.75,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => Products(
                          product: snapshot.data.documents[index],
                          press: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DetailsPage(
                                product: snapshot.data.documents[index],
                                appbartitle: categories[selected],
                              );
                            }));
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class Products extends StatelessWidget {
  final DocumentSnapshot product;
  final Function press;
  const Products({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.lightGreen),
                image: DecorationImage(
                    image: NetworkImage(product["image"].toString()),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10)),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              product["title"],
            ),
          ),
          Text(
            "Rs. " + product["price"].toString(),
          ),
        ],
      ),
    );
  }
}
