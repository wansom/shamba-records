import 'package:flutter/widgets.dart';
import 'package:shambarecords/app.dart';
import 'package:shambarecords/screens/complete_profile/complete_profile_screen.dart';
import 'package:shambarecords/screens/dummy.dart';
import 'package:shambarecords/screens/forgot_password/forgot_password_screen.dart';
import 'package:shambarecords/screens/home_screen.dart';
import 'package:shambarecords/screens/login_success/login_success_screen.dart';
import 'package:shambarecords/screens/otp/otp_screen.dart';
import 'package:shambarecords/screens/sign_in/sign_in_screen.dart';
import 'package:shambarecords/screens/splash/splash_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  MyHomePage.routeName: (context) => MyHomePage(),
  HomeScreen.routeName: (context) => HomeScreen(),
  Dummy.routeName: (context) => Dummy()
};
