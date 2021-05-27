import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/map_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/profile_view_model.dart';
import 'package:safwat_pharmacy/models/address_model.dart';

import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';
import 'package:safwat_pharmacy/view/custom_widgets/info_textField.dart';

class SaveAddress extends StatelessWidget {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String id;
  String name;
  String mobile;
  String address;
  String details;

  SaveAddress({this.id,this.name, this.mobile, this.address, this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          FlatButton(
            child: Text('Cancel'.toUpperCase()),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Location Information'.toUpperCase(),
                      fontWeight: FontWeight.bold,
                      size: SizeConfig.defaultSize * 1.8,
                      color: Colors.grey[800],
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<MapViewModel>(
                            init: Get.find(),
                            builder: (controller) => Expanded(
                                  child: Container(
                                      height: SizeConfig.defaultSize * 3,
                                      child: CustomText(
                                        text: address,
                                        size: SizeConfig.defaultSize * 1.8,
                                        fontWeight: FontWeight.bold,
                                      )),
                                )),
                        Container(
                          width: SizeConfig.defaultSize * 8,
                          child: FlatButton(
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey[800],
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 1.2,
                    ),
                    CustomText(
                      text: 'Additional Address Details',
                      color: Colors.grey[800],
                    ),
                    Form(
                      key: globalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoTextField(
                            hint: 'Where do you want us to drop your order',
                            hintStyle: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.5),
                            onSave: (value) {
                              details = value;
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.defaultSize * 8,
                          ),
                          CustomText(
                            text: 'Personal Information'.toUpperCase(),
                            fontWeight: FontWeight.bold,
                            size: SizeConfig.defaultSize * 1.8,
                            color: Colors.grey[800],
                          ),
                          GetBuilder<ProfileViewModel>(
                            init: Get.find(),
                            builder: (cont) => Column(
                              children: [
                                InfoTextField(
                                  hint: 'Mobile Number',
                                  initialValue: mobile,
                                  label: 'Mobile Number',
                                  onSave: (value) {
                                    mobile = value;
                                  },
                                ),
                                InfoTextField(
                                  hint: 'Name',
                                  initialValue: name,
                                  label: 'Name',
                                  onSave: (value) {
                                    name = value;
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 10,
                    )
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<MapViewModel>(
                  init: Get.find(),
                  builder: (controller) => CustomButton(
                    text: 'Save Address'.toUpperCase(),
                    press: () {
                      if (globalKey.currentState.validate()) {
                        globalKey.currentState.save();
                        controller.saveAddress(
                            address: AddressModel(
                              id:id ,
                                address: controller.currentAddress,
                                details: details,
                                mobile: mobile,
                                name: name));

                        Get.back(result: 'edit');
                      }
                    },
                    radius: 5,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
