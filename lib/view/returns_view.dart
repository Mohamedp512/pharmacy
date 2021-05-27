import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';

import 'custom_widgets/custom_text.dart';

class ReturnsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Returns',
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
          size: SizeConfig.defaultSize * 2,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Center(
        child: CustomText(
          text: 'No Returns',
          color: Colors.black,
          size: SizeConfig.defaultSize * 2,
        ),
      ),
    );
  }
}
