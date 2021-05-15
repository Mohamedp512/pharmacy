class ReviewModel {
  String orderId;
  String productId;
  String userId;
  String userName;
  String review;
  DateTime date;
  int rating;

  ReviewModel({
    this.orderId,
    this.productId,
    this.userId,
    this.review,
    this.rating,
    this.date,
    this.userName
  });

  ReviewModel.fromJson(Map<String,dynamic> map){
    if(map==null){
      return;
    }
    productId=map['productId'];
    userId=map['userId'];
    userName=map['userName'];
    date=map['date'];
    review=map['review'];
    rating=map['rating'];
  }
}
