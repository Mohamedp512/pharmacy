import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/map_view_model.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';
import 'package:safwat_pharmacy/helper/binding.dart';
import 'package:safwat_pharmacy/helper/local_storage_data.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/theme.dart';
import 'package:safwat_pharmacy/view/splash_view.dart';
import 'core/view_model/cart_view_model.dart';
import 'core/view_model/home_view_model.dart';
import 'core/view_model/prescription_view_model.dart';
import 'core/view_model/profile_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(CartViewModel());
  // Get.put(LocalStoreageData());
 // Get.put(ProfileViewModel());
 // Get.put(HomeViewModel());
  //Get.put(MapViewModel());
  //Get.put(PrescriptionViewModel());
  
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<LocalStoreageData>(
      init:Get.find() ,
      builder:(controller)=> GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Safwat Pharmacy',
          initialBinding: Binding(),
          localizationsDelegates: [
            AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          locale: controller.language==null?Locale('en',''):Locale(controller.language,''),
          supportedLocales: [Locale('en', ''), Locale('ar', '')],
          theme: theme(),
          home: SplashView(),
        ),
      );
    
  }
}
