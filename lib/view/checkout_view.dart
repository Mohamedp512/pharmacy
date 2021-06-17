import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/cart_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/map_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/order_view_model.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/add_address_view.dart';
import 'package:safwat_pharmacy/view/cart_view.dart';
import 'package:safwat_pharmacy/view/custom_widgets/control_view.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_title.dart';
import 'package:safwat_pharmacy/view/order_view.dart';
import 'package:safwat_pharmacy/view/select_address.dart';
import 'custom_widgets/custom_card.dart';
import 'custom_widgets/custom_checkout_item.dart';

class CheckoutView extends StatelessWidget {
  final cartController = Get.put(CartViewModel());
  final orderController = Get.put(OrderViewModel());
  final addressController = Get.put(MapViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: getTranslated(context, 'checkOut').toUpperCase(),
          size: SizeConfig.defaultSize * 2.2,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(CartView());
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * .77,
            child: ListView(
              children: [
                CustomTitle(
                  title: getTranslated(context, 'shippingInfo'),
                ),
                GetBuilder<MapViewModel>(
                  init: Get.put(MapViewModel()),
                  builder: (controller) => CustomCard(
                    child: addressController.addresses.length == 0
                        ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'No Address Available',
                              ),
                              FlatButton(
                                child: CustomText(
                                  text: 'Add',
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  Get.to(AddAddressView());
                                },
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    SizedBox(
                                      width: SizeConfig.defaultSize,
                                    ),
                                    GetBuilder<MapViewModel>(
                                      init: Get.find(),
                                      builder: (controller) => Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                  text: controller
                                                      .addresses[controller
                                                          .defaultIndex]
                                                      .name),
                                              CustomText(
                                                text: controller
                                                    .addresses[
                                                        controller.defaultIndex]
                                                    .mobile,
                                              ),
                                              CustomText(
                                                text: controller
                                                    .addresses[
                                                        controller.defaultIndex]
                                                    .address,
                                              ),
                                              CustomText(
                                                text: controller
                                                    .addresses[
                                                        controller.defaultIndex]
                                                    .details,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Spacer(),
                              FlatButton(
                                textColor: Colors.blue,
                                child: Text(
                                  getTranslated(context, 'change')
                                      .toUpperCase(),
                                ),
                                onPressed: () {
                                  Get.to(SelectAddress(
                                    radioIndex: addressController.defaultIndex,
                                  ));
                                },
                              )
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize * 2,
                ),
                CustomTitle(
                  title: getTranslated(context, 'cartItems'),
                  buttonText: getTranslated(context, 'edit'),
                  press: () {
                    Get.back();
                  },
                  button: true,
                ),
                CustomCard(
                  child: GetBuilder<CartViewModel>(
                    init: Get.find(),
                    builder: (controller) => ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) => CustomCheckOutItem(
                        img: controller.cartItems[index].img,
                        name: controller.cartItems[index].name,
                        qty: controller.cartItems[index].quantity.toString(),
                        total: (controller.cartItems[index].price *
                                controller.cartItems[index].quantity)
                            .toString(),
                      ),
                      separatorBuilder: (context, index) => Divider(),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize * 2,
                ),
                CustomTitle(
                  title: 'Order Summary',
                ),
                GetBuilder<CartViewModel>(
                  init: Get.find(),
                  builder: (controller) => CustomCard(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: getTranslated(context, 'itemTotal') +
                                  ': \n' +
                                  getTranslated(context, 'discount') +
                                  ': \n' +
                                  getTranslated(context, 'shipping') +
                                  ': ',
                            ),
                            Text(
                              '${controller.totalPrice}\n0\n0',
                              textDirection: TextDirection.rtl,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: getTranslated(context, 'total'),
                            ),
                            CustomText(
                              text: controller.totalPrice.toString(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize * 3,
                )
              ],
            ),
          ),

          //Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
            height: SizeConfig.defaultSize * 8,
            width: double.infinity,
            margin: EdgeInsets.only(
                left: SizeConfig.defaultSize * 1.5,
                bottom: SizeConfig.defaultSize * 1.5,
                right: SizeConfig.defaultSize * 1.5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: getTranslated(context, 'total').toUpperCase(),
                      size: SizeConfig.defaultSize * 1.8,
                    ),
                    GetBuilder<CartViewModel>(
                      init: Get.find(),
                      builder: (controller) => CustomText(
                        text: controller.totalPrice.toString() + ' LE',
                        size: SizeConfig.defaultSize * 2,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                CustomButton(
                  press: () async {
                    if(addressController.addresses.length!=0){
                      await orderController.addOrder(
                        address: addressController
                            .addresses[addressController.defaultIndex],
                        cartProducts: cartController.cartItems,
                        total: cartController.totalPrice);

                    cartController.clearCart();
                    Get.back();

                    var response = await Get.to(OrderView());
                    if (response == 'order') {
                      Get.to(ControlView());
                    }
                    }else{
                      Get.defaultDialog(
                        title: 'No Address Avaialble',content: CustomText(text: 'Please Add An Address',size: SizeConfig.defaultSize*1.8,));
                    }
                    
                  },
                  text: getTranslated(context, 'confirm'),
                  height: SizeConfig.defaultSize * 5,
                  width: SizeConfig.defaultSize * 12,
                  radius: 5,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
