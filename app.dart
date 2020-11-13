import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shambarecords/loading.dart';
import 'package:shambarecords/providers/user_provider.dart';
import 'package:shambarecords/screens/home_screen.dart';
import 'package:shambarecords/screens/splash/splash_screen.dart';

class MyHomePage extends StatefulWidget {
  static String routeName = "/app";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return SplashScreen();
        break;
      case Status.Unauthenticated:
        return SplashScreen();
        break;
      case Status.Authenticating:
        return Loading();
        break;
      case Status.Authenticated:
        return HomeScreen();
        break;
      default:
        return SplashScreen();
        break;
    }
  }
}
