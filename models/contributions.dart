import 'package:cloud_firestore/cloud_firestore.dart';

class LoanModel{
   String id;
  String farmername;
  String amount;
  bool verified;
  String bank;
  Timestamp date;
  String paymenttype;
  LoanModel(
      {this.id,
      this.farmername,
      this.amount,
      this.bank,
      this.verified,
      this.paymenttype,
      this.date});
  factory LoanModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return LoanModel(
        id: doc.documentID,
        farmername: data['email'] ?? '',
        amount: data['amount'],
        bank: data['bank'],
        verified: data['verified'],
        paymenttype: data['type'],
        date: data['date']);
  }
}