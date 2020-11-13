import 'package:cloud_firestore/cloud_firestore.dart';

class ContributionsModel {
  String id;
  String farmername;
  String amount;
  String cooperative;
  String bank;
  Timestamp date;
  String paymenttype;
  ContributionsModel(
      {this.id,
      this.farmername,
      this.amount,
      this.bank,
      this.cooperative,
      this.paymenttype,
      this.date});
  factory ContributionsModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return ContributionsModel(
        id: doc.documentID,
        farmername: data['farmername'] ?? '',
        amount: data['amount'],
        bank: data['bank'],
        cooperative: data['cooperative'],
        paymenttype: data['type'],
        date: data['date']);
  }
}
