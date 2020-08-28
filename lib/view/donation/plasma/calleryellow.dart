import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallerYellow extends StatelessWidget {
  String number;
  CallerYellow(String number) {
    this.number = number;
  }
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("Could not luanch $command");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.green,
      radius: 20,
      child: IconButton(
          icon: Icon(
            Icons.call,
            color: Colors.white,
          ),
          onPressed: () {
            customLaunch('tel:$number');
          }),
    );
  }
}
