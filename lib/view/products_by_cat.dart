import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/cart_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/home_view_model.dart';
import 'package:safwat_pharmacy/models/cart_item_model.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_card.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';
import 'package:safwat_pharmacy/view/custom_widgets/product_card.dart';
import 'package:safwat_pharmacy/view/detail_view.dart';

class ProductsByCat extends StatelessWidget {
  final String title;
  final CartViewModel cartController = Get.find();
  ProductsByCat({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: title,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<HomeViewModel>(
        init: Get.find(),
        builder: (controller) => GridView.builder(
          itemCount: controller.productsByCat.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 2.5,
              crossAxisCount: 2,
              crossAxisSpacing: SizeConfig.defaultSize,
              mainAxisSpacing: SizeConfig.defaultSize),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Get.to(DetailsView(product: controller.productsByCat[index]));
            },
            child: ProductCard(
              addFunction: () {
                cartController.addCartItem(CartItemModel(
                  img: controller.productsByCat[index].img,
                  name: controller.productsByCat[index].enName,
                  price: controller.productsByCat[index].price,
                  productId: controller.productsByCat[index].prodId,
                  quantity: 1
                ));
              },
              price: controller.productsByCat[index].price.toString(),
              img: controller.productsByCat[index].img,
              tag: controller.productsByCat[index].prodId,
              name: controller.productsByCat[index].enName,
            ),
          ),
        ),
      ),
    );
  }
}
