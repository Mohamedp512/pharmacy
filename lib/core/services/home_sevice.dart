import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService{
  final CollectionReference _catCollectionRef =
      FirebaseFirestore.instance.collection('Categories');
      final CollectionReference _subCatCollectionRef =
      FirebaseFirestore.instance.collection('subCategories');
      final CollectionReference _proCollectionRef =
      FirebaseFirestore.instance.collection('Products');
      final CollectionReference _carouselCollectionRef =
      FirebaseFirestore.instance.collection('carousel');

  Future<List<QueryDocumentSnapshot>> getCategories()async{
    var result=await _catCollectionRef.get();
    return result.docs;
  }

   Future<List<QueryDocumentSnapshot>> getProducts()async{
    var result=await _proCollectionRef.get();
    return result.docs;
  }
 Future<List<QueryDocumentSnapshot>> getSubCategories()async{
    var result=await _subCatCollectionRef.get();
    return result.docs;
  }
  Future<List<QueryDocumentSnapshot>>getCarouselProducts()async{
    var result=await _carouselCollectionRef.get();
    return result.docs;

  }
}