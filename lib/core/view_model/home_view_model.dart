import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/services/home_sevice.dart';
import 'package:safwat_pharmacy/models/carousel_model.dart';
import 'package:safwat_pharmacy/models/category_model.dart';
import 'package:safwat_pharmacy/models/product_model.dart';
import 'package:safwat_pharmacy/models/subCategory_model.dart';

class HomeViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<CategoryModel> get categories => _categories;
  List<CategoryModel> _categories = [];
  List<CarouselModel> get carouselPro => _carouselPro;
  List<CarouselModel> _carouselPro = [];
  List<SubCategoryModel> get subCategories => _subCategories;
  List<SubCategoryModel> _subCategories = [];
  List<SubCategoryModel> selectedSubCats = [];

  List<ProductModel> get products => _products;
  List<ProductModel> _products = [];
  List<ProductModel> productsByCat = [];

  Map<String, dynamic> favData;

  HomeViewModel() {
    getCategories();
    getProducts();
  }
  Future<List<CategoryModel>> getCategories() async {
    _loading.value = true;
    HomeService().getCategories().then((result) {
      for (int i = 0; i < result.length; i++) {
        _categories.add(CategoryModel(
            categoryId: result[i].id,
            img: result[i].data()['img'],
            title: result[i].data()['title']));
      }
      getSubCategories();
      _loading.value = false;

      update();
    });
  }

  getProducts() async {
    _loading.value = true;
    getFavoriteData();
    getCarouselData();
    HomeService().getProducts().then((result) {
      if (result != null) {
        for (int i = 0; i < result.length; i++) {
          _products.add(ProductModel(
            prodId: result[i].data()['id'],
            enName: result[i].data()['enName'],
            arName: result[i].data()['arName'],
            category: result[i].data()['category'],
            description: result[i].data()['description'] != null
                ? result[i].data()['description']
                : '',
            img: result[i].data()['img'] != null
                ? result[i].data()['img']
                : 'https://firebasestorage.googleapis.com/v0/b/safwat-pharmacy.appspot.com/o/drug-logo.jpg?alt=media&token=c43d91a6-b2b2-42d3-b5ce-aef0c72d192a',
            review: result[i].data()['review'] != null
                ? double.parse(result[i].data()['review'])
                : 0,
            genericName: result[i].data()['genericName'] != null
                ? result[i].data()['genericName']
                : '',
            price: double.parse(result[i].data()['price']),
            barcode: result[i].data()['barcode'] != null
                ? result[i].data()['barcode']
                : '',
            subCategory: result[i].data()['subCategory'] != null
                ? result[i].data()['subCategory']
                : '',
            isFavorite: favData == null
                ? false
                : favData[result[i].data()['id']] ?? false,
          ));
        }

        // _products.add(ProductModel.fromJson(result[i].data()));
//        print(_products.length);
      }
      _loading.value = false;
      update();
    });
  }

  List<SubCategoryModel> getsubCatByCat(String catId) {
    _loading.value = true;
    List<SubCategoryModel> extractedSubCats = [];
    extractedSubCats =
        _subCategories.where((subCat) => subCat.catId == catId).toList();
    selectedSubCats = extractedSubCats;
    update();
    _loading.value = false;
  }

  findProductsBySubCat(String subCatId) {
    _loading.value = true;
    List<ProductModel> result = [];
    result = _products.where((prod) => prod.subCategory == subCatId).toList();

    productsByCat = result;
    update();
    _loading.value = false;
  }

  List<ProductModel> get favoriteProducts {
    return _products.where((prod) => prod.isFavorite).toList();
  }

  Future<List<SubCategoryModel>> getSubCategories() async {
    HomeService().getSubCategories().then((result) {
      for (var i = 0; i < result.length; i++) {
        _subCategories.add(SubCategoryModel(
            id: result[i].id,
            catId: result[i].data()['catId'],
            img: result[i].data()['img'],
            title: result[i].data()['title']));
      }
    });
    update();
  }

  List<ProductModel> getSimilarProducts(ProductModel product) {
    return products
        .where((pro) =>
            pro.genericName
                .toLowerCase()
                .contains(product.genericName.toLowerCase()) &&
            pro.prodId != product.prodId)
        .toList();
  }

  Future<void> toggleFavoriteStatus(String id) async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    DocumentReference userFavRef =
        FirebaseFirestore.instance.collection('userFavorites').doc(userId);
    final product = _products.firstWhere((prod) => prod.prodId == id);
    product.isFavorite = !product.isFavorite;
    print(product.isFavorite);
    update();
    try {
      await userFavRef.set({id: product.isFavorite}, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> getFavoriteData() async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    DocumentReference userFavRef =
        FirebaseFirestore.instance.collection('userFavorites').doc(userId);
    var result = await userFavRef.get();
    favData = result.data();
    update();
  }

  Future<void> getCarouselData() async {
    HomeService().getCarouselProducts().then((result) {
      for (var i = 0; i < result.length; i++) {
        _carouselPro.add(CarouselModel(
            img: result[i].data()['img'], proId: result[i].data()['proId']));
      }
    });
    update();
  }

  List<ProductModel> getCarouselProduct() {
    List<ProductModel> carouselProducts = [];
    for (var i = 0; i < _carouselPro.length; i++) {
      carouselProducts.add(
          _products.firstWhere((pro) => pro.prodId == carouselPro[i].proId));
    }
    return carouselProducts;
  }

  List<ImageProvider> carImages() {
    List<ImageProvider> images = [];
    for (var i = 0; i < _carouselPro.length; i++) {
      images.add(NetworkImage(carouselPro[i].img));
    }
    return images;
  }
}
