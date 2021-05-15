import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/auth_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/home_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_cat.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_title.dart';
import 'package:safwat_pharmacy/view/custom_widgets/product_card.dart';
import 'package:safwat_pharmacy/view/detail_view.dart';
import 'custom_widgets/custom_text.dart';

class HomeScreen extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: Get.find(),
      builder: (controller) => controller.loading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              backgroundColor: Colors.grey.shade200,
              body: Column(
                children: [
                  Container(
                    height: SizeConfig.defaultSize * 15,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            width: double.infinity,
                            height: SizeConfig.defaultSize * 13,
                            decoration: BoxDecoration(color: kPrimaryColor),
                            child: Center(
                                child: CustomText(
                              text: 'Pharmacy',
                              fontWeight: FontWeight.bold,
                              size: SizeConfig.defaultSize * 3,
                              color: Colors.white,
                            )),
                          ),
                        ),
                        Positioned(
                          top: SizeConfig.defaultSize * 10,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.defaultSize),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.defaultSize * 2),
                            height: SizeConfig.defaultSize * 4.5,
                            width: SizeConfig.screenWidth * .8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade100),
                              color: Colors.grey.shade100,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: kSecondaryColor,
                                ),
                                SizedBox(
                                  width: SizeConfig.defaultSize * .5,
                                ),
                                CustomText(
                                  text: 'Search...',
                                  color: kSecondaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.defaultSize),
                            height: SizeConfig.defaultSize * 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Carousel(
                                showIndicator: true,
                                indicatorBgPadding: 2,
                                dotBgColor: Colors.transparent,
                                dotHorizontalPadding: 5,
                                dotIncreasedColor: Colors.red,
                                dotVerticalPadding: 5,
                                dotIncreaseSize: 1.5,
                                radius: Radius.circular(10),
                                animationCurve: Curves.easeInSine,
                                boxFit: BoxFit.fill,
                                //dotColor: kSecondaryColor,dotIncreaseSize: 1.5,
                                images: [
                                  AssetImage('assets/images/panadol_night.jpg'),
                                  AssetImage('assets/images/bep1.png'),
                                  AssetImage(
                                      'assets/images/panadol_extra_ad.jpg'),
                                  AssetImage('assets/images/bep2.jpg')
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.defaultSize * 2,
                          ),
                          CustomTitle(
                            title: 'Categories',
                          ),
                          controller.loading.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _listViewCategories(),
                          CustomTitle(
                            title: 'Best Collection',
                            button: true,
                          ),
                          _listViewProducts(),
                          SizedBox(
                            height: SizeConfig.defaultSize * 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _listViewCategories() {
    return GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (controller) => Container(
              height: SizeConfig.defaultSize * 18,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) => CustomCat(
                  catImg: controller.categories[index].img,
                  catTitle: controller.categories[index].title,
                ),
              ),
            ));
  }

  Widget _listViewProducts() {
    return GetBuilder<HomeViewModel>(
        init: Get.find(),
        builder: (controller) => controller.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: SizeConfig.defaultSize * 25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Get.to(DetailsView(
                        product: controller.products[index],
                      ));
                    },
                    child: ProductCard(
                      img: controller.products[index].img,
                      name: controller.products[index].enName,
                      price: ((controller.products[index].price)).toString(),
                    ),
                  ),
                ),
              ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.lineTo(0, size.height * .8);
    path.quadraticBezierTo(
        size.width * .001, size.height * .95, size.width * .069, size.height);
    path.lineTo(size.width * .931, size.height);
    path.quadraticBezierTo(
      size.width * 0.991,
      size.height * .95,
      size.width,
      size.height * .8,
    );
    path.lineTo(size.width, 0);
    return path;

    //throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    //throw UnimplementedError();
    return false;
  }
}
