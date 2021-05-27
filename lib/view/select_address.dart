import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/map_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/add_address_view.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';

import 'custom_widgets/custom_text.dart';

class SelectAddress extends StatefulWidget {
  int radioIndex;

  SelectAddress({this.radioIndex});
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  MapViewModel addressController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<MapViewModel>(
            init: Get.find(),
            builder: (controller) => Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.addresses.length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: RadioListTile<int>(
                      activeColor: kPrimaryColor,
                      title: CustomText(
                        text: '${controller.addresses[index].address}',
                        color: Colors.black,
                      ),
                      subtitle: CustomText(
                        text:
                            '${controller.addresses[index].name}\n${controller.addresses[index].mobile}',
                        color: Colors.grey.shade500,
                      ),
                      groupValue: widget.radioIndex,
                      value: index,
                      onChanged: (value) {
                        setState(() {
                          widget.radioIndex = value;
                        });
                        controller.changeAddressIndex(value);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.all(SizeConfig.defaultSize * 2),
                    width: double.infinity,
                    child: OutlineButton(
                      borderSide: BorderSide(color: Colors.grey[800]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          CustomText(
                            text: 'Add Address',
                            size: SizeConfig.defaultSize * 1.8,
                          ),
                        ],
                      ),
                      onPressed: () {Get.to(AddAddressView());},
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                radius: 5,
                text: 'Confirm'.toUpperCase(),
                press: () {
                  addressController.changeAddressIndex(widget.radioIndex);
                  Get.back();
                }),
          )
        ],
      ),
    );
  }
}
