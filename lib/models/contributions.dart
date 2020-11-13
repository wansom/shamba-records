import 'package:cloud_firestore/cloud_firestore.dart';

class ContributionModel {
  static const ID = "uid";
  static const NAME = "type";
  static const DATEPAID = "date";

  static const IMAGEURL = "photo";
  static const LASTNAME = 'lastname';
  static const PHONE = 'phone';

  String _name;
  String _date;
  String _id;

//  getters
  String get name => _name;

  String get datepaid => _date;

  String get id => _id;

  // public variables

  ContributionModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME] ?? 'Contribution';
    _date = snapshot.data[DATEPAID];
    _id = snapshot.data[ID];
  }
}
