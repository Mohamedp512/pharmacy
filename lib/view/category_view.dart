import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/home_view_model.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';

import 'package:safwat_pharmacy/size_config.dart';

import 'package:safwat_pharmacy/view/custom_widgets/custom_cat.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';
import 'package:safwat_pharmacy/view/products_by_cat.dart';

class CategoryView extends StatefulWidget {
  int indexSelected;


  CategoryView({this.indexSelected=0 });

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: getTranslated(context,'category'),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: Row(
            children: [
              Container(
                  width: SizeConfig.screenWidth * .3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.grey.shade100),
                  child: GetBuilder<HomeViewModel>(
                      init: Get.find(),
                      builder: (controller) => ListView.separated(
                            clipBehavior: Clip.antiAlias,
                            separatorBuilder: (context, index) => SizedBox(
                              height: SizeConfig.defaultSize * 1,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                controller.getsubCatByCat(
                                    controller.categories[index].categoryId);
                                setState(() {
                                  this.widget.indexSelected = index;
                                });
                              },
                              child: CustomCat(
                                color: index == this.widget.indexSelected
                                    ? Colors.white
                                    : Colors.grey.shade100,
                                catImg: controller.categories[index].img,
                                catTitle: controller.categories[index].title,
                              ),
                            ),
                            /* Container(
                              child: CustomText(
                                text: controller.categories[index].title,
                              ),
                            ), */
                            itemCount: controller.categories.length,
                          ))),
              GetBuilder<HomeViewModel>(
                  init: Get.find(),
                  builder: (controller) => controller.selectedSubCats.length ==
                          0
                      ? Container()
                      : Expanded(
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.693,
                                        crossAxisCount: 2),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.selectedSubCats.length,
                                itemBuilder: (context, index) => controller
                                        .loading.value
                                    ? Center(child: CircularProgressIndicator())
                                    : GestureDetector(
                                      onTap: (){
                                        controller.findProductsBySubCat(controller.selectedSubCats[index].id);
                                        Get.to(ProductsByCat(title: controller.selectedSubCats[index].title,));},
                                      child: CustomCat(
                                          catImg: controller
                                              .selectedSubCats[index].img,
                                          catTitle: controller
                                              .selectedSubCats[index].title,
                                        ),
                                    )),
                          ),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
