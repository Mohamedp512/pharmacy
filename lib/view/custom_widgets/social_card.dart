
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safwat_pharmacy/size_config.dart';
//import 'package:flutter_svg/flutter_svg.dart';


class SocialCard extends StatelessWidget {
  final String icon;
  final Function press;

  const SocialCard({Key key, this.icon, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.2),
        width: SizeConfig.defaultSize * 4,
        height: SizeConfig.defaultSize * 4,
        decoration:
            BoxDecoration(color: Color(0xFFF5F6F9), shape: BoxShape.circle),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
