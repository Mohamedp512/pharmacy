import 'package:safwat_pharmacy/models/cart_item_model.dart';
import 'package:safwat_pharmacy/models/product_model.dart';

class OrderModel {
  String id;
  String address;
  String mobile;
  double total;
  List<CartItemModel> products;
  DateTime dateTime;
  String status;

  OrderModel({
    this.id,
    this.address,
    this.mobile,
    this.total,
    this.products,
    this.dateTime,
    this.status,
  });

  OrderModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    address = map['address'];
    mobile = map['mobile'];
    total = map['total'];
    products = map['products'];
    dateTime = map['dateTime'];
    status=map['status'];
  }
  toJson() {
    return {
      'id': id,
      'address': address,
      'mobile': mobile,
      'total': total,
      'products': products,
      'dateTime': DateTime.now(),
      'status':status,
    };
  }
}
