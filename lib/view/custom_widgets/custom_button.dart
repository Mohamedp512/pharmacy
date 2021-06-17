
import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/costants.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final Function press;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  

  CustomButton({this.fontSize=18,this.press,this.height=50,this.text,this.width=double.infinity,this.radius=20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FlatButton(
        onPressed: press,
        color: kPrimaryColor,
        child: Text(
          text,textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,height: 1,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
