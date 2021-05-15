class ProductModel {
  String prodId,
      enName,
      arName,
      genericName,
      barcode,
      img,
      description,
      category,
      subCategory;
  double price, review;
  bool isFavorite;

  ProductModel({
    this.prodId,
    this.isFavorite,
    this.enName,
    this.category,
    this.subCategory,
    this.arName,
    this.description,
    this.genericName,
    this.barcode,
    this.img,
    this.review,
    this.price,
  });
  ProductModel.fromJson(Map<String, dynamic> map) {
    if(map==null){
      return;
    }
    prodId = map['id'];
    enName = map['enName'];
    arName = map['arName'];
    category = map['category'];
    review =map['review']!=null? double.parse(map['review']):0.0;
    subCategory = map['subCategory']!=null?map['subCategory']:'';
    description = map['description']!=null?map['description']:'';
    genericName = map['genericName']!=null?map['genericName']:'';
    barcode = map['barcode'];
    img = map['img'];
    //isFavorite=map['isFavorite']!=null?map['isFavorite']:false;
    price = map['price']!=null?double.parse(map['price']):0.0;
  }

  toJson() {
    return {
      'enName': enName,
      'arName': arName,
      'category': category,
      'isFavorite':isFavorite,
      'subCategory': subCategory,
      'review': review.toString(),
      'id': prodId,
      'description': description,
      'genericName': genericName,
      'barcode': barcode,
      'img': img,
      'price': price.toString()
    };
  }
}
