import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<bool> checkUser() async{
    return await databaseReference
        .collection("users")
        .document(uid)
        .get()
        .then((userSnapshot) {
          print(userSnapshot.data["Name"]);
          if(userSnapshot.data["Name"]==""){
            
            return false;
          }else{
            return true;
          }
      
    });
  }
}
