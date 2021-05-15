class CartItemModel {
  String productId;
  String name;
  String img;
  double price;
  int quantity;
  int currentRating;

  CartItemModel({
    this.productId,
    this.img,
    this.name,
    this.price,
    this.quantity,
    this.currentRating=0
  });

  CartItemModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    price = map['price'];
    quantity = map['quantity'];
    img = map['image'];
    productId=map['productId'];
    currentRating=map['currentRating'];
  }

  toJson() {
    return {
      'productId': productId,
      'name': name,
      'image': img,
      'price': price.toString(),
      'quantity': quantity.toString(),
      'currentRating':0
    };
  }
}
