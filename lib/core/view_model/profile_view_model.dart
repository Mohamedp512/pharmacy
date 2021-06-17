import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/helper/local_storage_data.dart';
import 'package:safwat_pharmacy/models/user_model.dart';

class ProfileViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  File get image => _image;
  File _image;
  UserModel get user => _user;
  UserModel _user;
  LocalStoreageData localStoreageData = Get.find();
  final picker = ImagePicker();
  String get currentImageUrl => _currentImageUrl;
  String _currentImageUrl;
  String oldUrl;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    _loading.value = true;
    await localStoreageData.getuserData.then((value) {
      print(value);
      _user = value;
    });
    _loading.value = false;
    update();
  }

  Future<void> getImage({ImageSource source}) async {
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      _image = File(pickedImage.path);
    } else {
      Get.snackbar('No Image', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM);
    }
    update();
  }

  Future uploadImage() async {
    String _filePath = DateTime.now().toString() + '_image.jpg';
if(_image!=null){
    try {
      _loading.value = true;
      var uploadTask =
          await FirebaseStorage.instance.ref().child(_filePath).putFile(_image);
      String url = await uploadTask.ref.getDownloadURL();
      await saveImage(url);
      _user.img = url;
      //await deleteImage();
      oldUrl = url;
      print(url);
      update();
      _loading.value = false;
    } on FirebaseException catch (e) {
      print(e);
    }}else{
      Get.snackbar('No Photo', 'No Photo added');
    }
  }

  Future saveImage(String imgUrl) async {
    DocumentReference user =
        FirebaseFirestore.instance.collection('Users').doc(_user.userId);
    await user.set({'img': imgUrl}, SetOptions(merge: true));
  }

  Future<void> deleteImage() async {
    oldUrl=_user.img;
    if (oldUrl != null) {
      String fileUrl = Uri.decodeFull(Path.basename(oldUrl))
          .replaceAll(new RegExp(r'(\?alt).*'), '');

      var photoRef = await FirebaseStorage.instance.ref();
      photoRef.child(fileUrl).delete();
    }
    //await FirebaseStorage.instance.ref().
  }

  Future<void> getCurrentImage() async {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('Users').doc(user.userId);
    DocumentSnapshot result = await userRef.get();
    Map<String, dynamic> data = result.data();
    _currentImageUrl = data['img'];
    update();
  }

  Future<void> updateUserData(String name, String mobile) async {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('Users').doc(user.userId);
    await userRef
        .set({'name': name, 'mobile': mobile}, SetOptions(merge: true));
    user.name = name;
    user.mobile = mobile;
    update();
    localStoreageData.setUser(user);
  }
}
