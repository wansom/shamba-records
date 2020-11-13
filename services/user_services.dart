import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shambarecords/models/payments_model.dart';
import 'package:shambarecords/models/user_model.dart';

import '../models/contributions.dart';


class UserServices {
  Firestore _firestore = Firestore.instance;
  String collection = "users";

  void createUser(Map data) {
    _firestore.collection(collection).document(data["uid"]).setData(data);
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).document(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });
  Future makePayment({String amount, String type}) async {
    var user = await FirebaseAuth.instance.currentUser();
    _firestore
        .collection(collection)
        .document(user.uid)
        .collection('contributions')
        .add({'amount': amount, 'date': DateTime.now(), 'type': type});
  }

  //orders stream
  Stream<List<ContributionsModel>> getOrders({FirebaseUser user}) {
    var ref = Firestore.instance
        .collection(collection)
        .document(user.uid)
        .collection('contributions');

    return ref.snapshots().map((list) => list.documents
        .map((doc) => ContributionsModel.fromFirestore(doc))
        .toList());
  }
//loans stream
  Stream<List<LoanModel>> getLoans({FirebaseUser user}) {
    var ref = Firestore.instance
        .collection('loans').where('email',isEqualTo: user.email);
        

    return ref.snapshots().map((list) => list.documents
        .map((doc) => LoanModel.fromFirestore(doc))
        .toList());
  }

  Future requestLoan({FirebaseUser user, String amount, String email}) async {
    await Firestore.instance.collection('loans').add({
      'amount': amount,
      'date': DateTime.now(),
      'verified': false,
      'email': user.email
    });
  }
  Future removeRecord(loan)async{
    await Firestore.instance.collection('loans').document(loan).delete();
  }
}
