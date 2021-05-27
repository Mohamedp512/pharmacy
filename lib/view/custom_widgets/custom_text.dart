import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/costants.dart';


class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;

  const CustomText({this.text, this.color=kPrimaryColor, this.size, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight),
          overflow: TextOverflow.fade,
          softWrap: true,
          
    );
  }
}