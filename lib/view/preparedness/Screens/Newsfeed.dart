import 'package:WeCare/view/preparedness/Screens/Bar.dart';
import 'package:WeCare/view/preparedness/Screens/List1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'Bar.dart';

class NewsFeed extends StatefulWidget {
  AsyncSnapshot _asyncSnapshot;
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  var temp;
  var time;
  var location;

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.weatherapi.com/v1/current.json?key= 5b7501f1b9194ad5a7c104420200808&q=Biratnagar");
    var results = jsonDecode(response.body);

    setState(() {
      this.temp = results['current']['temp_c'];

      this.location = results['location']['name'];

      this.time = results['location']['localtime'];
    });
  }

  @override
  void initState() {
    super.initState();

    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.phone),
          backgroundColor: Colors.deepPurple[900],
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(22))),
                backgroundColor: Colors.white,
                context: context,
                builder: (context) {
                  return ListView.builder(
                      padding: EdgeInsets.all(5),
                      scrollDirection: Axis.vertical,
                      addAutomaticKeepAlives: true,
                      itemCount: widget._asyncSnapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        if (!widget._asyncSnapshot.hasData)
                          return Center(
                              child: CircularProgressIndicator(
                            semanticsLabel: "Loading...",
                          ));
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                              onTap: () async {
                                return launch(
                                    "tel://${widget._asyncSnapshot.data.documents[index]["phone"].toString()}");
                              },
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                              tileColor: Colors.transparent,
                              subtitle: Text(
                                widget._asyncSnapshot.data
                                    .documents[index]["phone"]
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green),
                              ),
                              title: Text(
                                widget._asyncSnapshot.data.documents[index]
                                    ["service"],
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Colors.green),
                              ),
                              trailing: Icon(
                                Icons.phone,
                                color: Colors.red,
                              )),
                        );
                      });
                });
          },
          label: Text("Emergency Calls"),
        ),
        resizeToAvoidBottomPadding: false,
        drawer: Drawer(
          child: Bar(),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.deepPurple[600],
            flexibleSpace: Column(
              children: [
                Text(
                  "Disaster prepare &",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'georgia',
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Protection Tips",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'georgia',
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            actions: [
              IconButton(
                  splashRadius: 25.0,
                  enableFeedback: true,
                  icon: Icon(
                    Icons.notification_important,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {})
            ],
            centerTitle: true,
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection("Calls").snapshots(),
            builder: (BuildContext context, AsyncSnapshot _snapshots) {
              widget._asyncSnapshot = _snapshots;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SlidingContainer(
                            title: "Welcome",
                            initialOffsetx: -1,
                            intervalStart: 0,
                            intervalEnd: 0.5,
                            width: MediaQuery.of(context).size.width * 0.45,
                            radius: BorderRadius.horizontal(
                                right: Radius.circular(20))),
                        SlidingContainer(
                            title: temp != null && location != null
                                ? location.toString() +
                                    ", " +
                                    temp.toString() +
                                    "\u00b0C"
                                : " Loading",
                            initialOffsetx: 1,
                            intervalStart: 0.5,
                            intervalEnd: 1,
                            width: MediaQuery.of(context).size.width * 0.53,
                            radius: BorderRadius.horizontal(
                                left: Radius.circular(20)))
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    List1(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class SlidingContainer extends StatefulWidget {
  const SlidingContainer({
    Key key,
    @required this.title,
    @required this.initialOffsetx,
    @required this.intervalStart,
    @required this.intervalEnd,
    @required this.width,
    @required this.radius,
  }) : super(key: key);
  final String title;
  final double initialOffsetx;
  final double intervalStart;
  final double intervalEnd;
  final double width;
  final BorderRadiusGeometry radius;

  @override
  _SlidingContainerState createState() => _SlidingContainerState();
}

class _SlidingContainerState extends State<SlidingContainer>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> animation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );
    animation = Tween<Offset>(
      begin: Offset(widget.initialOffsetx, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(widget.intervalStart, widget.intervalEnd,
            curve: Curves.bounceInOut)));
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(child: child, position: animation);
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'georgia',
              ),
            ),
          ),
        ),
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.deepPurple[400],
          borderRadius: widget.radius,
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
