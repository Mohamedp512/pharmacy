import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/home_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';
import 'package:safwat_pharmacy/view/custom_widgets/product_card.dart';

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Favorites',
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
          size: SizeConfig.defaultSize * 2,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: GetBuilder<HomeViewModel>(
          init: Get.find(),
          builder: (controller) => controller.favoriteProducts.length != 0
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.793,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.favoriteProducts.length,
                  itemBuilder: (context, index) => ProductCard(tag:controller.favoriteProducts[index].prodId ,
                    button: true,
                    icon: Icon(Icons.delete,color: Colors.red,),
                    press: (){controller.toggleFavoriteStatus(controller.favoriteProducts[index].prodId);},
                    img: controller.favoriteProducts[index].img,
                    name: controller.favoriteProducts[index].enName,
                    price: controller.favoriteProducts[index].price.toString(),
                  ),
                )
              : Center(
                  child: CustomText(
                    text: 'No Favorites',color: Colors.black54,size: SizeConfig.defaultSize*2,
                  ),
                )),
    );
  }
}
