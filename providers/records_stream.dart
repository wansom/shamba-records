import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shambarecords/models/payments_model.dart';
import 'package:shambarecords/services/user_services.dart';

class RecordStream with ChangeNotifier {
  UserServices _userServices = UserServices();
  Stream records;
  ContributionsModel orderModel;
  //initialize provider
  RecordStream.initialize() {
    loadProducts();
  }
  //loading products
  loadProducts() async {
    final user = await FirebaseAuth.instance.currentUser();
    records = _userServices.getOrders(user: user);

    notifyListeners();
  }
}
