import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "firstname";
  static const EMAIL = "email";
  static const IDNUMBER = "idnumber";
  static const CART = "cart";
  static const SALE = 'sale';
  static const IMAGEURL = "photo";
  static const LASTNAME = 'lastname';
  static const PHONE = 'phone';

  String _name;
  String _email;
  String _id;
  String _idnumber;
  String _imageurl;
  String _lastname;
  String _phone;

//  getters
  String get name => _name;

  String get email => _email;

  String get id => _id;

  String get idnumber => _idnumber;
  String get imageurl => _imageurl;
  String get lastname => _lastname;
  String get phone => _phone;

  // public variables

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME] ?? 'User';
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _lastname = snapshot.data[LASTNAME] ?? 'Records';
    _imageurl = snapshot.data[IMAGEURL];
    _idnumber = snapshot.data[IDNUMBER] ?? '35****23';
    _phone = snapshot.data[PHONE] ?? '0705223050';
  }
}
