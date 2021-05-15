import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService{
  final CollectionReference _catCollectionRef =
      FirebaseFirestore.instance.collection('Categories');
      final CollectionReference _proCollectionRef =
      FirebaseFirestore.instance.collection('Products');

  Future<List<QueryDocumentSnapshot>> getCategories()async{
    var result=await _catCollectionRef.get();
    return result.docs;
  }

   Future<List<QueryDocumentSnapshot>> getProducts()async{
    var result=await _proCollectionRef.get();
    return result.docs;
  }
}