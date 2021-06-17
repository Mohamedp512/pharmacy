import 'package:safwat_pharmacy/models/subCategory_model.dart';

class CategoryModel {
String categoryId;
  String title;
  String img;
  List<SubCategoryModel> subCategories;

  CategoryModel({this.categoryId, this.title, this.img,this.subCategories});

  CategoryModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    
    title = map['title'];
    img = map['img'];
    
  }

  toJson() {
    return {
      'Id': categoryId,
      'title': title,
      'img': img,
      
    };
  }
}
