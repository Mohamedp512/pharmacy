import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/prescription_view_model.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';

import 'home_view_model.dart';
import 'map_view_model.dart';

class ControlViewModel extends GetxController {
  int _navigatorIndex = 0;

  get navigatorIndex => _navigatorIndex;
  @override
  void onInit() {
    // TODO: implement onInit
    Get.put(HomeViewModel());
    Get.put(MapViewModel());
    Get.put(PrescriptionViewModel());
    super.onInit();
  }

  void changeSelectedIndex(int selectedIndex) {
    _navigatorIndex = selectedIndex;
    update();
  }

  Future<bool> onBackPress(BuildContext context) {
    return Get.defaultDialog(
        title: getTranslated(context, 'confirm'),
        content: CustomText(
          text: getTranslated(context, 'doYouWantToExit'),
        ),
        actions: [
          FlatButton(
            child: CustomText(
              text: getTranslated(context, 'yes'),
            ),
            onPressed: () {Get.back(result: true);},
          ),
          FlatButton(
            child: CustomText(
              text: getTranslated(context, 'no'),
            ),
            onPressed: () {Get.back(result: false);},
          )
        ]);
  }
}
