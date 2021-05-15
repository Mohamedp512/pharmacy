import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/cart_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/home_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/models/cart_item_model.dart';
import 'package:safwat_pharmacy/models/product_model.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/cart_view.dart';
import 'package:safwat_pharmacy/view/custom_widgets/badge.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_title.dart';
import 'custom_widgets/product_card.dart';

class DetailsView extends GetWidget<HomeViewModel> {
  final ProductModel product;

  DetailsView({this.product});
  @override
  Widget build(BuildContext context) {
    controller.getSimilarProducts(product);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Product Details",
        ),
        actions: [
          GestureDetector(
              onTap: () {Get.to(CartView());},
              child: GetBuilder<CartViewModel>(
                  init: CartViewModel(),
                  builder: (controller) => controller.cartItems.length == 0
                      ? Icon(Icons.shopping_cart_outlined)
                      : Badge(
                          child: Icon(
                            Icons.shopping_cart,
                            color: kPrimaryColor,
                          ),
                          value: controller.cartItems.length.toString(),
                        )))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * .8,
            child: ListView(
              children: [
                Stack(children: [
                  Container(
                    height: SizeConfig.defaultSize * 30,
                    width: double.infinity,
                    // color: Colors.red,
                    child: Image.network(product.img),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GetBuilder<HomeViewModel>(
                      init: Get.find(),
                      builder:(controller)=> IconButton(
                        icon: product.isFavorite?Icon(Icons.favorite,color: Colors.red,) :Icon(Icons.favorite_border),
                        onPressed: () {
                         
                          controller.toggleFavoriteStatus(product.prodId);
                        },
                      ),
                    ),
                  )
                ]),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultSize,
                      vertical: SizeConfig.defaultSize),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: product.enName,
                        size: SizeConfig.defaultSize * 2.4,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize,
                      ),
                      CustomText(
                        text: product.price.toString() + ' EGP',
                        size: SizeConfig.defaultSize * 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 3,
                      ),
                      CustomText(
                        text: product.genericName.toUpperCase(),
                        size: SizeConfig.defaultSize * 2,
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize,
                      ),
                      CustomText(
                        text: product.description,
                        size: SizeConfig.defaultSize * 1.8,
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize,
                      ),
                      CustomTitle(
                        title: 'Similar Products',
                      ),
                      _similarProductsList()
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Spacer(),
          GetBuilder<CartViewModel>(
            init: CartViewModel(),
            builder: (controller) => Container(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.defaultSize,
                  horizontal: SizeConfig.defaultSize * 2),
              child: CustomButton(
                text: 'Add to Cart'.toUpperCase(),
                press: () {
                  controller.addCartItem(CartItemModel(
                      productId: product.prodId,
                      img: product.img,
                      name: product.enName,
                      price: product.price,
                      quantity: 1));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _similarProductsList() {
    List<ProductModel> products = controller.getSimilarProducts(product);

    return GetBuilder<HomeViewModel>(
        builder: (controller) => Container(
              margin: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
              height: SizeConfig.defaultSize * 25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsView(
                                  product: products[index],
                                )));
                  },
                  child: ProductCard(
                    img: products[index].img,
                    name: products[index].enName,
                    price: ((products[index].price)).toString(),
                  ),
                ),
              ),
            ));
  }
}
