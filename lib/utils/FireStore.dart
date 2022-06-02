import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sucial/model/User.dart';

class fireStoreHandler {
  Stream<QuerySnapshot> users() {
    return FirebaseFirestore.instance.collection("UserInfo").snapshots();
  }

  CollectionReference setUser () {
    return FirebaseFirestore.instance.collection("UserInfo");
  }

  Stream<List<UserObject>> isUserExist() {
    return FirebaseFirestore.instance.collection("UserInfo").snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => UserObject.fromJson(doc.data())).toList());
  }
  
}