import 'package:flutter/material.dart';
import 'package:shambarecords/services/auth.dart';

class Dummy extends StatefulWidget {
  static String routeName = "/dummy";
  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    return AuthService().handleAuth();
  }
}
