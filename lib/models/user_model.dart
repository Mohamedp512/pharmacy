class UserModel {
  String userId, email, name, img, mobile;

  UserModel({this.userId, this.email, this.name, this.img, this.mobile});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
    img = map['img'];
    mobile = map['mobile']!=null?map['mobile']:'';
  }

  toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'img': img,
      'mobile': mobile
    };
  }
}
