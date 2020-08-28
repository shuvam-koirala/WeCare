import 'package:WeCare/view/authentication/phoneauthUI/numeric_pad.dart';
import 'package:WeCare/view/preparedness/Screens/Newsfeed.dart';
import 'package:WeCare/view/register/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'continue_with_phone.dart';

class VerifyPhone extends StatefulWidget {
  final String phoneNumber;

  VerifyPhone({@required this.phoneNumber});

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String smssent = "";

  final firestoreInstance = Firestore.instance;

  void _onPresseds() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection("usersAuthNumbers")
        .document(firebaseUser.uid)
        .setData({
      "phoneNumbers": phoneNo,
    }).then((value) {});
  }

  Future<void> signIn(String smsCode) async {
    print("hey");
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      _onPresseds();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Register()));

      print("the greatest test");
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Verify phone",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      "Code is sent to " + widget.phoneNumber,
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF818181),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildCodeNumberBox(
                            smssent.length > 0 ? smssent.substring(0, 1) : ""),
                        buildCodeNumberBox(
                            smssent.length > 1 ? smssent.substring(1, 2) : ""),
                        buildCodeNumberBox(
                            smssent.length > 2 ? smssent.substring(2, 3) : ""),
                        buildCodeNumberBox(
                            smssent.length > 3 ? smssent.substring(3, 4) : ""),
                        buildCodeNumberBox(
                            smssent.length > 4 ? smssent.substring(4, 5) : ""),
                        buildCodeNumberBox(
                            smssent.length > 5 ? smssent.substring(5, 6) : ""),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Didn't recieve code? ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF818181),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Resend the code to the user");
                          },
                          child: Text(
                            "Request again",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        FirebaseAuth.instance.currentUser().then((user) {
                          if (user != null) {
                            // Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsFeed()),
                            );
                          } else {
                            // Navigator.of(context).pop();
                            print(smssent);
                            signIn(smssent);
                            print("this is the voice");
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFDC3D),
                          //color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Verify and Create Account",
                            style: TextStyle(
                              //color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          NumericPad(
            onNumberSelected: (value) {
              print(value);
              setState(() {
                if (value != -1) {
                  if (smssent.length < 7) {
                    smssent = smssent + value.toString();
                  }
                } else {
                  smssent = smssent.substring(0, smssent.length - 1);
                }
              });
            },
          ),
        ],
      )),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 49,
        height: 49,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
