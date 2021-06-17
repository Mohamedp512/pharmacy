import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';

class CustomCat extends StatelessWidget {
  final String catTitle;
  final String catImg;
  final Color color;
  CustomCat({this.catTitle, this.catImg, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize * 2,
                vertical: SizeConfig.defaultSize),
            height: SizeConfig.defaultSize * 10,
            width: SizeConfig.defaultSize * 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
               ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                image: catImg,
                placeholder: 'assets/images/spinner.gif',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            catTitle,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
