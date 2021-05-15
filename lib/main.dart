import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/helper/binding.dart';
import 'package:safwat_pharmacy/helper/local_storage_data.dart';
import 'package:safwat_pharmacy/theme.dart';
import 'package:safwat_pharmacy/view/auth/login_screen.dart';
import 'package:safwat_pharmacy/view/custom_widgets/control_view.dart';

import 'core/view_model/cart_view_model.dart';
import 'core/view_model/home_view_model.dart';
import 'core/view_model/order_view_model.dart';
import 'core/view_model/profile_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(CartViewModel());
  Get.put(LocalStoreageData());
  Get.put(ProfileViewModel());
  Get.put(HomeViewModel());
  //Get.put(ProfileViewModel());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safwat Pharmacy',
      initialBinding: Binding(),
      theme: theme(),
      home: ControlView(),
    );
  }
}

