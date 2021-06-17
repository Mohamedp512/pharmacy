import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';
import 'package:safwat_pharmacy/size_config.dart';

import 'custom_text.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final VoidCallback press;
  final bool button;
  final String buttonText;
  CustomTitle(
      {@required this.title,
      this.press,
      this.button = false,
      this.buttonText = 'View All'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize, vertical: SizeConfig.defaultSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            size: SizeConfig.defaultSize * 2,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
          button
              ? FlatButton(
                  onPressed: press,
                  child: CustomText(
                    text: getTranslated(context,'viewAll'),
                    color: kTextColor,
                  ))
              : Container(),
        ],
      ),
    );
  }
}
