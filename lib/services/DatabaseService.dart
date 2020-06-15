import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aria_makeup/models/User.dart';

class DataBase {
  final uid;
  DataBase({this.uid});
  final databaseReference = Firestore.instance;

  void createRecord() async {
    print("Record Created");
    await databaseReference.collection("users").document(uid).setData({
      'Name': '',
      'Address': [],
      'Phone No': '',
      'uid': this.uid,
      'email': ''
    });
  }

  Future<bool> checkUser() async {
    return await databaseReference
        .collection("users")
        .document(uid)
        .get()
        .then((userSnapshot) {
      print(userSnapshot.data["Name"]);
      if (userSnapshot.data["Name"] == "") {
        return false;
      } else {
        return true;
      }
    });
  }

  Map<String, Product> _productMapFromSnapshot(QuerySnapshot snapshot) {
    return Map.fromIterable(snapshot.documents, key: (value) => value.data["id"], value: (value) => Product(
          name: value.data['Name'],
          price: value.data['Price'],
          images: value.data['Images']));
  }
  Map<String, List<String>> _categoryMapFromSnapshot(QuerySnapshot snapshot) {
    return Map.fromIterable(snapshot.documents, key: (value) => value.data["category"], value: (value) => value.data['Products']);
  }

  Stream<Map<String, List<String>>> get categoryStream {
    return databaseReference.collection("Categories").snapshots().map(_categoryMapFromSnapshot);
  }

  Stream<Map<String, Product>> get productStream {
    return databaseReference.collection("Products").snapshots().map(_productMapFromSnapshot);
  }
}