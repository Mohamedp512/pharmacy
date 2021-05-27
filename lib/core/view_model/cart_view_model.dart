import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/services/database/cart_database_helper.dart';
import 'package:safwat_pharmacy/models/cart_item_model.dart';

class CartViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  List<CartItemModel> _cartItems = [];
  List<CartItemModel> get cartItems => _cartItems;
  double get totalPrice => _totalPrice;
  double _totalPrice = 0.0;
  var dbHelper = CartDatabaseHelper.db;
  CollectionReference cartRef=FirebaseFirestore.instance.collection('cart');


  CartViewModel() {
    getAllCartItems();
  }

  addCartItem(CartItemModel cartItem) async {
   // String userId=FirebaseAuth.instance.currentUser.uid;
    //await cartRef.doc(userId).set()

    if ((_cartItems.singleWhere((item) => item.name == cartItem.name,
            orElse: () => null)) ==
        null) {
      var dbHelper = CartDatabaseHelper.db;
      await dbHelper.insert(cartItem);
      _cartItems.add(cartItem);
      _totalPrice += cartItem.price * cartItem.quantity;

      Get.snackbar('Product Added', 'Product Added to Cart',
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);

      update();
    } else {
      Get.snackbar('Item Available', 'Item already available in cart',
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  getAllCartItems() async {
    _loading.value = true;
    
    _cartItems = await dbHelper.getAllCartItems();
    getTotalPrice();
    _loading.value = false;

    update();
  }

  getTotalPrice() {
    for (int i = 0; i < _cartItems.length; i++) {
      _totalPrice += _cartItems[i].price * _cartItems[i].quantity;
      update();
    }
  }

  deleteCartItem(CartItemModel cartItem)async{
    _cartItems.removeWhere((item)=>item.productId==cartItem.productId);
    await dbHelper.deleteCartItem(cartItem);
    _totalPrice-=cartItem.quantity*cartItem.price;
    //getAllCartItems();
    update();
  }

  increaseQyantity(int index)async {
    _cartItems[index].quantity++;
    _totalPrice += _cartItems[index].price;
     await dbHelper.updateCartItem(_cartItems[index]);
    update();
  }

  decreaseQyantity(int index) async {
    if(_cartItems[index].quantity>1){
      _cartItems[index].quantity--;
    _totalPrice -= _cartItems[index].price;
    await dbHelper.updateCartItem(_cartItems[index]);
    update();
    }
    for(CartItemModel cartItem in _cartItems){
      print(cartItem.productId);
    }
  }

  clearCart()async{
    _cartItems.clear();
    _totalPrice=0;
    await dbHelper.deleteCartDatabase();
    update();

  }
}
