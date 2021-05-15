import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';

class CustomCheckOutItem extends StatelessWidget {
 final String img;
 final String name;
 final String qty;
 final String total;

  CustomCheckOutItem({this.name,this.img, this.qty, this.total});
 
 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize),
            height: SizeConfig.defaultSize * 5,
            width: SizeConfig.defaultSize * 5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        img))),
          ),
          SizedBox(width: SizeConfig.defaultSize,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: name,
              ),
              Text.rich(
                TextSpan(
                    text: 'Quantity: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.defaultSize * 1.6),
                    children: [
                      TextSpan(
                          text: qty
                              .toString(),
                          style: TextStyle(
                              fontSize:
                                  SizeConfig.defaultSize * 1.6,
                              fontWeight: FontWeight.bold))
                    ]),
              ),
              SizedBox(height: SizeConfig.defaultSize*3,),
              Text.rich(
                TextSpan(
                    text: 'Total: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.defaultSize * 1.6),
                    children: [
                      TextSpan(
                          text: (total)
                              .toString(),
                          style: TextStyle(
                              fontSize:
                                  SizeConfig.defaultSize * 1.6,
                              fontWeight: FontWeight.bold))
                    ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
