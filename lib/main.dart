import 'package:WeCare/view/authentication/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/authentication/birdgewrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<String>.value(
      value: Service().user,
      child: MaterialApp(home: Wrapper()),
    );
  }
}
