import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/cart_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/home_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';
import 'package:safwat_pharmacy/models/cart_item_model.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/checkout_view.dart';
import 'package:safwat_pharmacy/view/custom_widgets/cart_item_listtile.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';

import 'custom_widgets/empty_cart_view.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      init: CartViewModel(),
      builder:(controller)=> Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: getTranslated(context,'cart'),
            size: SizeConfig.defaultSize * 2.2,
          ),
          centerTitle: true,
        ),
        body: controller.cartItems.length==0?EmptyCart(): Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<CartViewModel>(
              init: Get.find(),
              builder: (controller) => Expanded(
                child: Container(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.defaultSize,
                        horizontal: SizeConfig.defaultSize * .7),
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) => controller.cartItems.isEmpty
                        ? Center(
                            child: CustomText(
                              text: 'Empty Cart',
                              size: SizeConfig.defaultSize * 3,
                            ),
                          )
                        : CartItemListtile(
                            img: controller.cartItems[index].img,
                            name: controller.cartItems[index].name,
                            price: controller.cartItems[index].price,
                            quantity: controller.cartItems[index].quantity,
                            increase: () {
                              controller.increaseQyantity(index);
                            },
                            decrease: () {
                              controller.decreaseQyantity(index);
                            },
                            deleteItem: (direction) async {
                              controller
                                  .deleteCartItem(controller.cartItems[index]);
                            },
                          ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize*1.5),
              height: SizeConfig.defaultSize * 7,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: getTranslated(context,'total').toUpperCase(),
                        color: kSecondaryColor,
                      ),
                      GetBuilder<CartViewModel>(
                        init: Get.find(),
                        builder: (controller) => CustomText(
                          text: controller.totalPrice.toString() + ' LE',
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          size: SizeConfig.defaultSize * 2,
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(blurRadius: 0.5, color: Colors.black38),
                    ], borderRadius: BorderRadius.circular(10)),
                    child: CustomButton(
                      text: getTranslated(context,'checkOut').toUpperCase(),
                      radius: 10,
                      press: () {
                        Get.to(CheckoutView());
                      },
                      height: SizeConfig.defaultSize * 4.5,
                      width: SizeConfig.defaultSize * 15,
                      fontSize: SizeConfig.defaultSize * 1.6,
                    ),
                  )
                ],
              ),
              /*  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                CustomButton(text: 'Checkout'.toUpperCase(),press: (){},),
                CustomText(text: 'Total',color: kSecondaryColor,)
              ],), */
            )
          ],
        ),
      ),
    );
  }
}
