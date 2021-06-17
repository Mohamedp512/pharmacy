import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safwat_pharmacy/core/services/firestore_user.dart';
import 'package:safwat_pharmacy/core/view_model/profile_view_model.dart';
import 'package:safwat_pharmacy/helper/local_storage_data.dart';
import 'package:safwat_pharmacy/models/user_model.dart';
import 'package:safwat_pharmacy/view/auth/login_screen.dart';
import 'package:safwat_pharmacy/view/custom_widgets/control_view.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  String email, password, name;
  Rx<User> _user = Rx<User>();
  String get user => _user.value?.email;
  LocalStoreageData localStoreageData = Get.find();
  ProfileViewModel profileViewModel = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      getCurrentUserData(_auth.currentUser.uid);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void googleSignInMethod() async {
    //Get.defaultDialog(content: CircularProgressIndicator());
    Get.dialog(Center(child: CircularProgressIndicator()));
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await _auth.signInWithCredential(credential).then((user) async {
      await saveUser(user);
    });
    Get.back();
    Get.offAll(ControlView());
  }

  void facebookLoginMethod() async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    FacebookLoginResult result = await _facebookLogin.logIn(['email']);
    final accessToken = result.accessToken.token;
    if (result.status == FacebookLoginStatus.loggedIn) {
      final faceCredential = FacebookAuthProvider.credential(accessToken);
      await _auth.signInWithCredential(faceCredential).then((user) async {
        await saveUser(user);
      });
      Get.back();
      Get.offAll(ControlView());
    }
  }

  void signInWitEmailAndPassword() async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        getCurrentUserData(user.user.uid);
      });
      Get.offAll(ControlView());
    } catch (e) {
      Get.snackbar('Error', e.message,
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void creatAccountWitEmailAndPassword() async {
    Get.defaultDialog(title: '', content: CircularProgressIndicator());
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        await saveUser(user);
      });

      Get.offAll(ControlView());
    } catch (e) {
      Get.snackbar('Error', e.message,
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    await _auth.signOut();
    await localStoreageData.deleteUser();
    Get.back();
    Get.offAll(LoginScreen());
  }

  void saveUser(UserCredential user) async {
   
    UserModel userModel = UserModel(
      userId: user.user.uid,
      email: user.user.email,
      name: name == null ? user.user.displayName : name,
      img: user.user.photoURL!=null?user.user.photoURL:'',
    );
   
    await FireStoreUser().addUser(userModel);
    setUser(userModel);
  }

  void getCurrentUserData(String uid) async {
    FireStoreUser().getCurrentUser(uid).then((value) async {
      await setUser(UserModel.fromJson(value.data()));
    });
  }

  setUser(UserModel user) async {
    await localStoreageData.setUser(user);
  profileViewModel.getCurrentUser();
  }
}
