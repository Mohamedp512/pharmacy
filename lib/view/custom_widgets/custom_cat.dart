import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';

class CustomCat extends StatelessWidget {
   final String catTitle;
   final String catImg;

 CustomCat({this.catTitle, this.catImg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal:SizeConfig.defaultSize*2,vertical: SizeConfig.defaultSize),
          height: SizeConfig.defaultSize * 10,
          width: SizeConfig.defaultSize*10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(catImg),fit: BoxFit.cover)),
        ),
        Text(catTitle,style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
      ],
    );
  }
}
