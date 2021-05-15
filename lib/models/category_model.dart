class CategoryModel {
String categoryId;
  String title;
  String img;

  CategoryModel({this.categoryId, this.title, this.img});

  CategoryModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    //categoryId = map['Id'];
    title = map['title'];
    img = map['img'];
  }

  toJson() {
    return {
     // 'Id': categoryId,
      'title': title,
      'img': img,
    };
  }
}
