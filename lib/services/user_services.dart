import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shambarecords/models/user_model.dart';

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
}
