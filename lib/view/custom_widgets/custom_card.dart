import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/size_config.dart';

class CustomCard extends StatelessWidget {
  Widget child;
  
  CustomCard({
    this.child
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize*1.5),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(5)),
      child: child
    );
  }
}
