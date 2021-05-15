import 'dart:convert';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../costants.dart';

class LocalStoreageData extends GetxController {
  Future<UserModel> get getuserData async {
    try {
      UserModel user = await _getUserData();
      if (user == null) {
        return null;
      }
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString(CACHED_USER_DATA);
    return UserModel.fromJson(json.decode(user));
  }

  setUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CACHED_USER_DATA, json.encode(user.toJson()));
  }
  void deleteUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
