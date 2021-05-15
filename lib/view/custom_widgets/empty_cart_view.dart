import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/size_config.dart';


class EmptyCart extends StatelessWidget {
  const EmptyCart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: SizeConfig.screenHeight*.9,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/emptyCart1.png',height: SizeConfig.defaultSize*30,width: 200,),
              Text('Your Cart is empty', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('Be sure to fill your cart with something you like'),
            ],
          ),
        ),
      ),
    );
  }
}
