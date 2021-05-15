import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safwat_pharmacy/models/user_model.dart';

class FireStoreUser {
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUser(UserModel userModel) async {
    await _userRef.doc(userModel.userId).set(userModel.toJson());

    
  }
  Future<DocumentSnapshot> getCurrentUser(String uid)async{
      return await _userRef.doc(uid).get();
    }

  
}
