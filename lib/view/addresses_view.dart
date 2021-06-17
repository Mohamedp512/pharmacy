import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/map_view_model.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';
import 'package:safwat_pharmacy/view/add_address_view.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/save_address.dart';

import '../costants.dart';
import '../size_config.dart';
import 'custom_widgets/custom_text.dart';

class AddressessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: getTranslated(context,'shippingAddress'),
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
          size: SizeConfig.defaultSize * 2,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: GetBuilder<MapViewModel>(
                  init: Get.put(MapViewModel()),
                  builder: (controller) => controller.loading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.addresses.length == 0
                          ? Center(
                              child: Text('No Addresses'),
                            )
                          : Container(
                              child: ListView.separated(
                                itemCount: controller.addresses.length,
                                itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.all(5),
                                  height: SizeConfig.defaultSize * 22,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.location_city,
                                            color: Colors.blue,
                                          ),
                                          Spacer(),
                                          FlatButton(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                  size: SizeConfig.defaultSize *
                                                      2,
                                                ),
                                                Text(getTranslated(context,'edit')),
                                              ],
                                            ),
                                            onPressed: () {
                                              Get.to(SaveAddress(
                                                id: controller.addresses[index].id,
                                                address: controller
                                                    .addresses[index].address,
                                                details: controller
                                                    .addresses[index].details,
                                                mobile: controller.addresses[index].mobile,
                                                name:controller.addresses[index].name ,
                                              ));
                                            },
                                          ),
                                          FlatButton(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.red,
                                                  size: SizeConfig.defaultSize *
                                                      2,
                                                ),
                                                Text(getTranslated(context,'delete')),
                                              ],
                                            ),
                                            onPressed: () {
                                              print(controller
                                                  .addresses[index].id);
                                              controller.deleteAddress(
                                                  controller.addresses[index]);
                                            },
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey.shade400,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(getTranslated(context,'name')),
                                              SizedBox(
                                                width:
                                                    SizeConfig.defaultSize * 5,
                                              ),
                                              CustomText(
                                                text: controller
                                                    .addresses[index].name,
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: SizeConfig.defaultSize * 5,
                                            margin: EdgeInsets.symmetric(
                                                vertical:
                                                    SizeConfig.defaultSize *
                                                        1.5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  getTranslated(context,'address'),
                                                  overflow: TextOverflow.fade,
                                                ),
                                                SizedBox(
                                                  width:
                                                      SizeConfig.defaultSize *
                                                          3.5,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: CustomText(
                                                      text:
                                                          '${controller.addresses[index].address}\n${controller.addresses[index].details}',
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(getTranslated(context,'mobile')),
                                              SizedBox(
                                                width: SizeConfig.defaultSize *
                                                    4.5,
                                              ),
                                              CustomText(
                                                text: controller
                                                    .addresses[index].mobile,
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              press: () {
                Get.to(AddAddressView());
              },
              text: getTranslated(context,'addNewAddress'),
            ),
          )
        ],
      ),
    );
  }
}
