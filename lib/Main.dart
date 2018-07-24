import 'package:flutter/material.dart';
import 'package:flutter_mvp/ListUser/ListUser.Screen.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter MVP',
        theme: new ThemeData(
            primaryColor: Colors.amber, accentColor: Colors.amber),
        debugShowCheckedModeBanner: false,
        home: new Scaffold(body: new MainScreen()));
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListUser();
  }
}
