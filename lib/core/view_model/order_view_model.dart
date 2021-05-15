import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/profile_view_model.dart';
import 'package:safwat_pharmacy/models/cart_item_model.dart';
import 'package:safwat_pharmacy/models/order_model.dart';
import 'package:safwat_pharmacy/models/review_model.dart';
import 'package:safwat_pharmacy/models/user_model.dart';

class OrderViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  UserModel get user => _user;
  UserModel _user;
  final ProfileViewModel profileController = Get.find();
  List<OrderModel> get orders => _orders;
  List<OrderModel> _orders = [];
  List<ReviewModel> reviews = [];

  CollectionReference _orderRef =
      FirebaseFirestore.instance.collection('orders');
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //getCurrentUser();
   // getOrders();
  }

  OrderViewModel() {
    getReviews();
    getOrders();
  }

  /* Future<void> getCurrentUser() async {
    _loading.value = true;
    await localStoreageData.getuserData.then((value) {
      _user = value;
    });
    _loading.value = false;
    update();
  }
 */
  Future<void> getOrders() async {
    final List<OrderModel> _loadedOrder = [];
    _loading.value = true;
    //getReviews();
    var userOrders =
        await _orderRef.doc(profileController.user.userId).get().then((result) {
      if (result.data() != null) {
        var extractedData = result.data();

        print(reviews.length);
        extractedData.forEach((orderId, orderData) {
          _loadedOrder.add(OrderModel(
              id: orderId,
              address: orderData['address'],
              dateTime: DateTime.parse(orderData['dateTime']),
              mobile: orderData['mobile'],
              status: orderData['status'],
              total: double.parse(orderData['total']),
              products: (orderData['products'] as List<dynamic>)
                  .map((item) => CartItemModel(
                      img: item['image'],
                      name: item['name'],
                      price: double.parse(item['price']),
                      productId: item['id'],
                      quantity: int.parse(item['quantity']),
                      currentRating: reviews.length == 0
                          ? 0
                          :reviews[reviews.indexWhere((rev)=>(rev.orderId==orderId&&rev.productId==item['id']))].rating
                          /* ((reviews.firstWhere(
                                      (rev) => (rev.orderId==orderId&&rev.productId == item['id'])))
                                  .rating) */ ??
                              0))
                  .toList()));
        });
      }
    });
    _orders = _loadedOrder.reversed.toList();
    update();
    _loading.value = false;
  }

  Future<void> addOrder(
      {List<CartItemModel> cartProducts, String address, double total}) async {
    UserModel user = profileController.user;
    String dateTime = DateTime.now().toString();
    String orderId = user.userId.substring(0, 5) +
        dateTime.substring(0, 4) +
        dateTime.substring(5, 7) +
        dateTime.substring(8, 10) +
        dateTime.substring(20);

    print(cartProducts);
    Map<String, dynamic> newOrder = {
      'status': 'InProcess',
      'address': address,
      'dateTime': DateTime.now().toString(),
      'mobile': user.mobile,
      'total': total.toString(),
      'products': cartProducts
          .map((cp) => {
                'id': cp.productId,
                'image': cp.img,
                'name': cp.name,
                'quantity': cp.quantity.toString(),
                'price': cp.price.toString(),
                'currentRating': 0
              })
          .toList()
    };
    _orderRef
        .doc(user.userId)
        .set({orderId: newOrder}, SetOptions(merge: true));
    //
    print('orrrrrrrrr' + newOrder['products'][0]['id']);
    var order = OrderModel(
        address: address,
        dateTime: DateTime.now(),
        id: orderId,
        mobile: user.mobile,
        products: cartProducts,
        status: 'inProcess',
        total: total);
    _orders.insert(0, order);
    _loading.value = false;
    update();

    print(orders[0].products[0].productId);
  }

  ratingProduct({int rating, String proId}) async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    DocumentReference reviews =
        FirebaseFirestore.instance.collection('reviews').doc(proId);
    await reviews.set({
      userId: {'notes': 'excellent', 'rating': rating}
    }
        // { orderId:{'products':{'0':{'currentRating':rating}}}}
        //{'${orderId}.products.0.currentRating': rating},
        );
  }

  rateProduct(
      {CartItemModel product, int rate, String orderId, int index}) async {
    String userId = FirebaseAuth.instance.currentUser.uid;

    var field = FirebaseFirestore.instance.collection('orders').doc(userId);
    //await field.update({orderId:{'products':{'0':{'currentRating':rate}}}},);
    //await field.update({'${orderId}.products.$index.currentRating':rate},);
    product.currentRating = rate;
    update();
    print(product.productId);
    Map jsonProduct = {
      'id': product.productId,
      'image': product.img,
      'name': product.name,
      'price': product.price,
      'currentRating': rate,
      'quantity': product.quantity
    };
    field.update({
      '$orderId.products': {'$index': jsonProduct}
    });
    update();
  }

  Future<int> getRating(String prodId) async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    var reviewRef = await FirebaseFirestore.instance
        .collection('reviews')
        .doc(prodId)
        .get();
    var data = reviewRef.data();
    int rating = data[userId]['rating'];
    return rating;
  }

  getReviews() async {
    await FirebaseFirestore.instance.collection('reviews').get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        value.docs[i].data().forEach((id, data) => reviews.add(ReviewModel(
            orderId: id,
            date: DateTime.parse(data['date']),
            productId: data['productId'],
            rating: data['rating'],
            review: data['review'],
            userId: data['userId'],
            userName: data['userName'])));
        //print(i);

      }

      // print('reviiiiiiiiii:' + '${reviews.length}');
    });
    update();
    print('rrrrrrrrrrrrrrrr' + '${reviews.length}');
  }

  addReview(
      {CartItemModel product, String orderId, int rate, String notes}) async {
   
    ReviewModel review = ReviewModel(
        productId: product.productId,
        rating: rate,
        review: notes ?? '',
        userId: profileController.user.userId,
        date: DateTime.now(),
        orderId: orderId,
        userName: profileController.user.name);
    Map<String, dynamic> newReview = {
      'productId': product.productId,
      'userId': profileController.user.userId,
      'userName': profileController.user.name,
      'rating': rate,
      'orderId': orderId,
      'review': notes ?? '',
      'date': DateTime.now().toString()
    };
   
    if (reviews.singleWhere((item) => item.orderId == review.orderId,
            orElse: () => null) ==
        null) {
      reviews.add(review);
      setRate(orderId: orderId, prodId: product.productId,rate:rate );
      update();
    }
    reviews[reviews.indexWhere((item) => item.productId == product.productId)] =
        review;
        setRate(orderId: orderId, prodId: product.productId,rate:rate );
    update();
    

    DocumentReference reviewRef =
        FirebaseFirestore.instance.collection('reviews').doc(review.productId);
    reviewRef.set({'${orderId}': newReview});
    update();
  }

  ReviewModel getRate(String ordId, String prod) {
    var review = reviews
        .firstWhere((rev) => rev.productId == prod && rev.orderId == ordId);
    print(review.userName);
    print(reviews.length);
  }
  setRate({String orderId,String prodId, int rate}){
    OrderModel order=orders.firstWhere((item)=>item.id==orderId);
    CartItemModel product=order.products.firstWhere((item)=>item.productId==prodId);
    product.currentRating=rate;
    update();

  }
}
