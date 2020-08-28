//import 'package:dropdownfield/dropdownfield.dart';
import 'package:WeCare/view/authentication/phoneauthUI/continue_with_phone.dart';
import 'package:WeCare/view/donation/blood/bloodDonation.dart';
import 'package:WeCare/view/preparedness/Screens/Newsfeed.dart';
import 'package:flutter/material.dart';
import 'district.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String selectCity;
  final citiesSelect = TextEditingController();
  String bloodtypes;
  String select;

  final firestoreInstance = Firestore.instance;

  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController email = new TextEditingController();

//firestore

  // void _onPressed() {
  //   firestoreInstance.collection("users").add({
  //     "first name": firstname.text,
  //     "last name": lastname.text,
  //     "email": email.text,
  //     "address": selectCity,
  //     "birthDate": select,
  //     "bloodType": bloodtypes,
  //   }).then((value) {
  //     print(value.documentID);
  //   });
  // }
  void _onPressed() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("users").document(firebaseUser.uid).setData({
      "first name": firstname.text,
      "last name": lastname.text,
      "email": email.text,
      "address": selectCity,
      //"birthDate": _date.toString(),
      "gender": select,
      "phoneNumber": phoneNo,
      "bloodType": bloodtypes,
    }).then((_) {
      print("success!");
    });
  }

  DateTime _date = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1970),
        lastDate: DateTime(2100));

    if (picked != null && picked != _date) {
      print(_date.toString());

      setState(() {
        _date = picked;
        print(_date.toString());
      });
    }
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Registration"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(children: [
        Column(
          children: [
            Form(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: firstname,
                      decoration: InputDecoration(
                        labelText: "First Name",
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 1.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: lastname,
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 1.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple, width: 1.0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton(
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        hint: Text("Select District"),
                        items: cities.map((value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                        value: selectCity,
                        onChanged: (value) {
                          setState(() {
                            selectCity = value;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple, width: 1.0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton(
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        hint: Text("Blood Type"),
                        items: bloodType.map((value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                        value: bloodtypes,
                        onChanged: (value) {
                          setState(() {
                            bloodtypes = value;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      enabled: false,
                      initialValue: phoneNo,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 1.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      addRadioButton(0, 'Male'),
                      addRadioButton(1, 'Female'),
                      addRadioButton(2, 'Others'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      selectDate(context);
                    },
                    child: Container(
                      height: 50,
                      width: 370,
                      child: Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(_date.toString()),
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 1.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 45,
                    width: 320,
                    child: RaisedButton(
                      color: Colors.deepPurple,
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        _onPressed();

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsFeed()));
                      },
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ]),
    );
  }
}
