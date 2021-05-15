import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/cart_view_model.dart';
import 'package:safwat_pharmacy/size_config.dart';

import 'custom_text.dart';

class CartItemListtile extends StatelessWidget {
  String name;
  String img;
  double price;
  int quantity;
  Function increase;
  Function decrease;
  Function deleteItem;

  CartItemListtile({
    this.deleteItem,
    this.img,
    this.name,
    this.price,
    this.quantity,
    this.decrease,
    this.increase,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      init: Get.find(),
      builder: (controller) => Dismissible(
        key: ValueKey('1'),
        background: Container(
          padding: EdgeInsets.only(right:SizeConfig.defaultSize*2),
          alignment:Alignment.centerRight ,
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                            Icon(Icons.delete_outlined,color: Colors.white,size: SizeConfig.defaultSize*5,),
                            CustomText(text: 'Delete',color: Colors.white,fontWeight: FontWeight.bold,size: SizeConfig.defaultSize*2,),
            ],
          ),
        ),
        onDismissed: deleteItem,
        direction: DismissDirection.endToStart,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
          height: SizeConfig.defaultSize * 15,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(blurRadius: 0.2, offset: Offset(0, 0.1))]),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(SizeConfig.defaultSize),
                height: SizeConfig.defaultSize * 12,
                width: SizeConfig.defaultSize * 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(img), fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(SizeConfig.defaultSize),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name,
                        size: SizeConfig.defaultSize * 1.7,
                      ),
                      CustomText(
                        text: price.toString() + ' LE',
                        size: SizeConfig.defaultSize * 1.8,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              /* Container(
                                height: SizeConfig.defaultSize*2.5,
                                width: SizeConfig.defaultSize*3,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(7)),
                                    child: Center(child: Icon(Icons.remove))
                              ),
                               */
                              SizedBox(
                                width: SizeConfig.defaultSize * 3.2,
                                height: SizeConfig.defaultSize * 2.5,
                                child: OutlineButton(
                                  onPressed: decrease,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.defaultSize),
                                child: CustomText(
                                  text: quantity.toString(),
                                  size: SizeConfig.defaultSize * 1.8,
                                ),
                              ),
                              /* Container(
                                  height: SizeConfig.defaultSize * 2.5,
                                  width: SizeConfig.defaultSize * 3,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Center(
                                      child: Icon(
                                    Icons.add,
                                  ))) */
                              SizedBox(
                                width: SizeConfig.defaultSize * 3.2,
                                height: SizeConfig.defaultSize * 2.5,
                                child: OutlineButton(
                                  onPressed: increase,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
