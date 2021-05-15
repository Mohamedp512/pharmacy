import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/auth_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/cart_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/control_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/view/account_view.dart';
import 'package:safwat_pharmacy/view/auth/login_screen.dart';
import 'package:safwat_pharmacy/view/cart_view.dart';
import 'package:safwat_pharmacy/view/category_view.dart';
import 'package:safwat_pharmacy/view/custom_widgets/badge.dart';
import 'package:safwat_pharmacy/view/home_screen.dart';
import 'package:safwat_pharmacy/view/prescription_view.dart';
import 'package:safwat_pharmacy/view/profile_view.dart';

class ControlView extends GetWidget<AuthViewModel> {
  List<Widget> _widgetList = [
    HomeScreen(),
    CategoryView(),
    CartView(),
    PrescriptionView(),
    AccountView()
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user == null)
          ? LoginScreen()
          : GetBuilder<ControlViewModel>(
            init: ControlViewModel(),
              builder: (controller) => Scaffold(
                body: _widgetList[controller.navigatorIndex],
                bottomNavigationBar: bottomNavigationBar(),
              ),
            );
    });
  }
}

Widget bottomNavigationBar() {
  return GetBuilder<ControlViewModel>(
    init: Get.find(),
    builder: (controller) => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Category'),
        BottomNavigationBarItem(
            icon: GetBuilder<CartViewModel>(
                init: Get.find(),
                builder: (controller) => controller.cartItems.length == 0
                    ? Icon(Icons.shopping_cart_outlined)
                    : Badge(
                        child: Icon(Icons.shopping_cart_outlined),
                        value: controller.cartItems.length.toString(),
                      )),
            label: 'Cart'),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined), label: 'Prescription'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Account'),
      ],
      selectedItemColor: kPrimaryColor,
      currentIndex: controller.navigatorIndex,
      onTap: (index) => controller.changeSelectedIndex(index),
    ),
  );
}
