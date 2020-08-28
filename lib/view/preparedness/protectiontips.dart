import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tips extends StatelessWidget {
  final String apptitle;
  Tips({@required this.apptitle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(apptitle.toUpperCase()),
          centerTitle: true,
          backgroundColor: Colors.deepPurple[400],
          automaticallyImplyLeading: true,
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection(apptitle).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(
                    child: CircularProgressIndicator(
                  semanticsLabel: "Loading...",
                ));
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.0,
                          mainAxisSpacing:
                              MediaQuery.of(context).size.height * 0.005,
                          crossAxisCount: 1),
                      itemBuilder: (context, index) {
                        return TipsContainer(
                          title: snapshot.data.documents[index]["title"],
                          initialOffsetx: index.isEven ? -1 : 1,
                          intervalStart: 0,
                          intervalEnd: 0.5,
                          width: MediaQuery.of(context).size.width,
                          image: NetworkImage(
                              snapshot.data.documents[index]["image"]),
                        );
                      },
                    )
                  ],
                ),
              );
            }));
  }
}

class TipsContainer extends StatefulWidget {
  const TipsContainer({
    Key key,
    @required this.title,
    @required this.initialOffsetx,
    @required this.intervalStart,
    @required this.intervalEnd,
    @required this.width,
    @required this.image,
  }) : super(key: key);
  final String title;
  final double initialOffsetx;
  final double intervalStart;
  final double intervalEnd;
  final double width;
  final ImageProvider image;
  @override
  _TipsContainerState createState() => _TipsContainerState();
}

class _TipsContainerState extends State<TipsContainer>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> animation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    animation = Tween<Offset>(
      begin: Offset(widget.initialOffsetx, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(widget.intervalStart, widget.intervalEnd,
            curve: Curves.easeInOutQuad)));
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
        margin: const EdgeInsets.all(7.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.25,
                        minHeight: MediaQuery.of(context).size.height * 0.25,
                        maxWidth: MediaQuery.of(context).size.width,
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: widget.image, fit: BoxFit.cover),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'georgia',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        width: widget.width,
        //  height: widget.height,
        decoration: BoxDecoration(
            color: Colors.deepPurple[500],
            borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
