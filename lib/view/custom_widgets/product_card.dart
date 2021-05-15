import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';

import 'custom_button.dart';
import 'custom_text.dart';

class ProductCard extends StatelessWidget {
  String img;
  String price;
  String name;
  bool button;
  Widget icon;
  Function press;

  ProductCard(
      {this.img,
      this.name,
      this.price,
      this.button = false,
      this.icon,
      this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize,
          vertical: SizeConfig.defaultSize * .2),
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      height: SizeConfig.defaultSize * 25,
      width: SizeConfig.defaultSize * 18,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                blurRadius: 1, offset: Offset(0.5, 0.9), spreadRadius: 0.1)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
            height: SizeConfig.defaultSize * 10,
            color: Colors.white,
            child: Stack(children: [
              Center(
                  child: img != null
                      ? Image.network(
                          img,
                          fit: BoxFit.contain,
                        )
                      : Image.asset('assets/images/no-img.png')),
              Positioned(
                top: -10,
                right: -10,
                child:button? IconButton(
                  icon: icon,onPressed: press,
                ):Container(),
              )
            ]),
          ),
          Expanded(
            child: Container(
              /* padding:
                  EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 0.5), */
              child: Text(
                name,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: SizeConfig.defaultSize * 1.7,
                ),
                maxLines: 2,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize * 0.5,
          ),
          CustomText(
            text: price + ' EGP',
            fontWeight: FontWeight.bold,
          ),
          Spacer(),
          Center(
            child: CustomButton(
              width: SizeConfig.defaultSize * 14,
              text: 'Add to Cart',
              press: () {},
              fontSize: SizeConfig.defaultSize * 1.4,
              height: SizeConfig.defaultSize * 3.5,
            ),
          )
        ],
      ),
    );
  }
}
