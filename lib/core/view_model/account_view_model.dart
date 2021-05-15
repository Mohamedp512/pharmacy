import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safwat_pharmacy/helper/local_storage_data.dart';
import 'package:safwat_pharmacy/view/auth/login_screen.dart';

class AccountViewModel extends GetxController {
LocalStoreageData localStoreageData =Get.find();

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    localStoreageData.deleteUser();
    Get.offAll(LoginScreen());
  }
}
