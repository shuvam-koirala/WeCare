import 'package:WeCare/view/firstAid/pages/aidbody.dart';
import 'package:WeCare/view/preparedness/Screens/Bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatelessWidget {
  static AsyncSnapshot _asyncSnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.phone),
        backgroundColor: Colors.green,
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
                    itemCount: _asyncSnapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      if (!_asyncSnapshot.hasData)
                        return Center(
                            child: CircularProgressIndicator(
                          semanticsLabel: "Loading...",
                        ));
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                            onTap: () async {
                              return launch(
                                  "tel://${_asyncSnapshot.data.documents[index]["phone"].toString()}");
                            },
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            hoverColor: Colors.transparent,
                            subtitle: Text(
                              _asyncSnapshot.data.documents[index]["phone"]
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
                              _asyncSnapshot.data.documents[index]["service"],
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "First Aid Package",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Bar()));
            }),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("Calls").snapshots(),
        builder: (BuildContext context, AsyncSnapshot _snapshots) {
          _asyncSnapshot = _snapshots;
          return BodyPage();
        },
      ),
    );
  }
}
