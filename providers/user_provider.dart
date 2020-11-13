import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shambarecords/models/user_model.dart';
import 'package:shambarecords/services/user_services.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();

  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;

  Status get status => _status;

  FirebaseUser get user => _user;

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var currentuser = await FirebaseAuth.instance.currentUser();
      await Firestore.instance
          .collection('users')
          .document(currentuser.uid)
          .setData({
        'name': '',
        'email': email,
        'uid': currentuser.uid,
        'stripeId': '',
        'imageurl': '',
      });

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future updateUser(
      {String firstname,
      String lastname,
      String idnumber,
      String gender,
      String address,
      String altPhone,
      String phoneNumber,
      String birthdate}) async {
    await Firestore.instance.collection('users').document(user.uid).updateData({
      'firstname': firstname,
      'lastname': lastname,
      'idnumber': idnumber,
      'gender': gender,
      'address': address,
      'birthdate': birthdate,
      'phone': phoneNumber,
      'altphone': altPhone
    });
    notifyListeners();
  }
}
