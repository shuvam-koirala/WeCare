// import 'package:WeCare/view/donation/blood/bloodDonation.dart';
// import 'package:WeCare/view/donation/blood/bloodtypesearch.dart';
// import 'package:WeCare/view/donation/blood/requestList.dart';
// import 'package:WeCare/view/home.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:WeCare/view/authentication/authservice.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// final firstColor = Color(0xffc10000);
// final secondColor = Colors.red;

// class TopScreen extends StatefulWidget {
//   @override
//   _TopScreenState createState() => _TopScreenState();
// }

// class _TopScreenState extends State<TopScreen> {
//   final firestoreInstance = Firestore.instance;

//   Service obj = new Service();

//   // void _onPressed() async {
//   //   dynamic firebaseUser = obj.currentUser();
//   //   firestoreInstance
//   //       .collection("users")
//   //       .document(firebaseUser.uid)
//   //       .get()
//   //       .then((value) {
//   //     print(value.data);
//   //     print("hello");
//   //   });
//   // }

//   void toast() {
//     Fluttertoast.showToast(
//         msg: "Thank you for the contribution.. Try to refresh",
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         toastLength: Toast.LENGTH_LONG);
//   }

//   void toastdel() {
//     Fluttertoast.showToast(
//         msg: "You are no longer a donar..Thank you",
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         toastLength: Toast.LENGTH_LONG);
//   }

// // Retrieve and Set data in firebase from users to bloodDonation

//   bool icon = true;
//   // Icon iconvalue = Icon(Icons.person_add);

//   void _onPressed() async {
//     var firebaseUser = await FirebaseAuth.instance.currentUser();
//     firestoreInstance
//         .collection("users")
//         .document(firebaseUser.uid)
//         .get()
//         .then((value) {
//       print("help");
//       firestoreInstance
//           .collection("bloodDonation")
//           .document(firebaseUser.uid)
//           .setData({
//         "first name": value["first name"],
//         "last name": value["last name"],
//         "email": value["email"],
//         "address": value["address"],
//         //"birthDate": _date.toString(),
//         "gender": value["gender"],
//         "phoneNumber": value["phoneNumber"],
//         "bloodType": value["bloodType"],
//       }).then((_) {
//         print("success!");
//         toast();

//         setState(() {
//           icon = !icon;
//         });
//       });
//     });
//   }

//   // deleting the data form the database

//   void _ondel() async {
//     var firebaseUser = await FirebaseAuth.instance.currentUser();
//     firestoreInstance
//         .collection("bloodDonation")
//         .document(firebaseUser.uid)
//         .delete()
//         .then((_) {
//       print("removed!");
//       toastdel();
//       setState(() {
//         icon = !icon;
//       });
//     });
//   }

//   //retreive A+ data

//   // void _apositive() {
//   //   firestoreInstance
//   //       .collection("bloodDonation")
//   //       .where("bloodType", isEqualTo: "A+")
//   //       .getDocuments()
//   //       .then((value) {
//   //     value.documents.forEach((result) {
//   //       print(result.data);
//   //       TypeSearch();
//   //       BloodDonation(false);
//   //     });
//   //   });
//   // }

//   void _apositive() {
//     print("hello");

//     setState(() {
//       BloodDonation(false);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 360,
//       child: Stack(
//         children: <Widget>[
//           Container(
//             height: 300,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [firstColor, secondColor]),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     offset: Offset(0.0, 10),
//                     blurRadius: 10.0,
//                   ),
//                 ]),
//           ),
//           Positioned(
//             top: 70,
//             bottom: 0,
//             right: 20,
//             left: 20,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.only(bottom: 10),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                             height: 30,
//                             child: IconButton(
//                                 icon: Icon(Icons.arrow_back),
//                                 onPressed: () => Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Home())))),
//                       ),
//                       SizedBox(
//                         width: 60,
//                       ),
//                       Expanded(
//                         flex: 5,
//                         child: Center(
//                           child: Text('Blood Requests',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Montserrat')),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           height: 30,
//                           child: icon
//                               ? IconButton(
//                                   icon: Icon(Icons.person_add),
//                                   onPressed: _onPressed)
//                               : IconButton(
//                                   icon: Icon(Icons.delete), onPressed: _ondel),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 250,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           offset: Offset(0.0, 0.5),
//                           blurRadius: 10,
//                         )
//                       ]),
//                   child: Container(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.all(32),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text('291',
//                                           style: TextStyle(
//                                               fontSize: 36,
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily: 'Montserrat')),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text(
//                                         '-12%',
//                                         style: TextStyle(
//                                             color: Colors.orange,
//                                             fontWeight: FontWeight.bold,
//                                             fontFamily: 'Montserrat'),
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         'Available',
//                                         style:
//                                             TextStyle(fontFamily: 'Montserrat'),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         '-49%',
//                                         style: TextStyle(
//                                             color: Colors.red,
//                                             fontWeight: FontWeight.bold,
//                                             fontFamily: 'Montserrat'),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text(
//                                         '481',
//                                         style: TextStyle(
//                                             fontSize: 36,
//                                             fontWeight: FontWeight.bold,
//                                             fontFamily: 'Montserrat'),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         'Requests',
//                                         style:
//                                             TextStyle(fontFamily: 'Montserrat'),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               InkWell(
//                                 onTap: _apositive,
//                                 child: Container(
//                                   height: 60,
//                                   width: 60,
//                                   child: Card(
//                                     child: Stack(
//                                       children: [
//                                         Center(
//                                           child: Text(
//                                             "A+",
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 30,
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 60,
//                                 width: 60,
//                                 child: Card(
//                                   child: Stack(
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           "A-",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 30,
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               Container(
//                                 height: 60,
//                                 width: 60,
//                                 child: Card(
//                                   child: Stack(
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           "B+",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 30,
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               Container(
//                                 height: 60,
//                                 width: 60,
//                                 child: Card(
//                                   child: Stack(
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           "B-",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 30,
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               Container(
//                                 height: 60,
//                                 width: 60,
//                                 child: Card(
//                                   child: Stack(
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           "O+",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 30,
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               Container(
//                                 height: 60,
//                                 width: 60,
//                                 child: Card(
//                                   child: Stack(
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           "AB+",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 25,
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               Container(
//                                 height: 60,
//                                 width: 60,
//                                 child: Card(
//                                   child: Stack(
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           "AB-",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 30,
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
