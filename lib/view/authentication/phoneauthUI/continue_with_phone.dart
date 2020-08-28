import 'package:WeCare/view/authentication/authservice.dart';
import 'package:WeCare/view/authentication/phoneauthUI/numeric_pad.dart';
import 'package:WeCare/view/authentication/phoneauthUI/verify_phone.dart';
import 'package:WeCare/view/register/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String verificationId;

class ContinueWithPhone extends StatefulWidget {
  Function toogleBetween;
  ContinueWithPhone({this.toogleBetween});
  @override
  _ContinueWithPhoneState createState() => _ContinueWithPhoneState();
}

String phoneNo = "+977";

class _ContinueWithPhoneState extends State<ContinueWithPhone> {
  // String verificationId;
  String smssent;

  Future<void> verifyPhonee() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      setState(() {
        verificationId = verId;
      });
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      verificationId = verId;
      smsCodeDialoge(context).then((value) {
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (AuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  // Future<bool> smsCodeDialoge(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return new AlertDialog(
  //         title: Text('Provide OTP'),
  //         content: TextField(
  //           onChanged: (value) {
  //             this.smssent = value;
  //           },
  //         ),
  //         contentPadding: EdgeInsets.all(10.0),
  //         actions: <Widget>[
  //           new FlatButton(
  //               onPressed: () {
  //                 FirebaseAuth.instance.currentUser().then((user) {
  //                   if (user != null) {
  //                     Navigator.of(context).pop();
  //                     print("the register test");
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(builder: (context) => Home()),
  //                     );
  //                   } else {
  //                     Navigator.of(context).pop();
  //                     signIn(smssent);
  //                     print("the another test");
  //                   }
  //                 });
  //               },
  //               child: Text(
  //                 'Done',
  //                 style: TextStyle(color: Colors.blue),
  //               ))
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<bool> smsCodeDialoge(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new VerifyPhone(phoneNumber: phoneNo);
        });
  }

  // Future<void> signIn(String smsCode) async {
  //   final AuthCredential credential = PhoneAuthProvider.getCredential(
  //     verificationId: obj.verificationId,
  //     smsCode: smsCode,
  //   );
  //   await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Register()));
  //     print("the greatest test");
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.close,
          size: 30,
          color: Colors.black,
        ),
        title: Text(
          "Continue with phone",
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
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.7, 0.9],
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFF7F7F7),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 130,
                    child: Image.asset('lib/assets/holding-phone.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 64),
                    child: Text(
                      "You'll receive a 6 digit code to verify next.",
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF818181),
                      ),
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
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Enter your phone",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          phoneNo,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           VerifyPhone(phoneNumber: phoneNo)),
                        // );
                        await verifyPhonee();
                        // return showDialog(
                        //     context: context,
                        //     barrierDismissible: false,
                        //     builder: (BuildContext context) {
                        //       return new Center(
                        //         child: Text("Loading"),
                        //       );
                        //     });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Color(0xFFFFDC3D),
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
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
              setState(() {
                if (value != -1) {
                  phoneNo = phoneNo + value.toString();
                } else {
                  phoneNo = phoneNo.substring(0, phoneNo.length - 1);
                }
              });
            },
          ),
        ],
      )),
    );
  }
}
