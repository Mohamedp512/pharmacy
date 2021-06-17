import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/auth_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/cart_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/control_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/home_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/profile_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';
import 'package:safwat_pharmacy/helper/network_controller.dart';
import 'package:safwat_pharmacy/view/account_view.dart';
import 'package:safwat_pharmacy/view/auth/login_screen.dart';
import 'package:safwat_pharmacy/view/cart_view.dart';
import 'package:safwat_pharmacy/view/category_view.dart';
import 'package:safwat_pharmacy/view/custom_widgets/badge.dart';
import 'package:safwat_pharmacy/view/custom_widgets/no_connection_view.dart';
import 'package:safwat_pharmacy/view/home_screen.dart';
import 'package:safwat_pharmacy/view/prescription_view.dart';

import 'custom_text.dart';


class ControlView extends GetWidget<AuthViewModel> {

  NetworkController _networkController=Get.put<NetworkController>(NetworkController());

  List<Widget> _widgetList = [
    HomeScreen(),
    CategoryView(),
    CartView(),
    PrescriptionView(),
    AccountView()
  ];
  @override
  Widget build(BuildContext context) {
    
    //Get.put(ProfileViewModel());
    Future<bool> onBackPress() {
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
    return Obx(() {
      Get.lazyPut(()=>AuthViewModel());
     // Get.lazyPut(()=>ProfileViewModel());
      return (
        _networkController.connectionState.value==0?NoConnectionView():
        ((Get.find<AuthViewModel>()).user == null)
          ? LoginScreen()
          : GetBuilder<ControlViewModel>(
            init: ControlViewModel(),
              builder: (controller) => WillPopScope(
                onWillPop: onBackPress,
                child: Scaffold(
                  body: _widgetList[controller.navigatorIndex],
                  bottomNavigationBar: bottomNavigationBar(context),
                ),
              ),
         )  ) ;
    });
    
  }
}


Widget bottomNavigationBar(BuildContext context) {
  return GetBuilder<ControlViewModel>(
    init: Get.put(ControlViewModel()),
    builder: (controller) => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: getTranslated(context,'home')),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: getTranslated(context,'category')),
        BottomNavigationBarItem(
            icon: GetBuilder<CartViewModel>(
                init: Get.find(),
                builder: (controller) => controller.cartItems.length == 0
                    ? Icon(Icons.shopping_cart_outlined)
                    : Badge(
                        child: Icon(Icons.shopping_cart_outlined),
                        value: controller.cartItems.length.toString(),
                      )),
            label: getTranslated(context,'cart')),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined), label: getTranslated(context,'prescription')),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: getTranslated(context,'account')),
      ],
      selectedItemColor: kPrimaryColor,
      currentIndex: controller.navigatorIndex,
      onTap: (index) => controller.changeSelectedIndex(index),
    ),
  );
}
