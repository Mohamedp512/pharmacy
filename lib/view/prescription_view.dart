import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:safwat_pharmacy/core/view_model/prescription_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/profile_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/add_prescription.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';


class PrescriptionView extends StatelessWidget {
  final ProfileViewModel profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: getTranslated(context,'medicalPrescription'),
            color: kPrimaryColor,
          ),
          centerTitle: true,
          elevation: 1,
          leading: Container(),
          actions: [Container()],
        ),
        body: GetBuilder<PrescriptionViewModel>(
          init: Get.put(PrescriptionViewModel()),
          builder: (controller) => Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              controller.prescriptions.length == 0
                  ? Expanded(
                      child: Container(
                        child: Center(
                          child: CustomText(
                            text: 'No Prescriptions',
                          ),
                        ),
                      ),
                    )
                  : controller.loading.value
                      ? Expanded(
                          child: Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                              child: ListView.separated(
                          itemCount: controller.prescriptions.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) => Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(text: getTranslated(context,'orderId')+' :', children: [
                                    TextSpan(
                                        text:
                                            controller.prescriptions[index].id,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            height: 1.5,
                                            color: Colors.black))
                                  ]),
                                ),
                                SizedBox(
                                  height: SizeConfig.defaultSize,
                                ),
                                Text.rich(
                                  TextSpan(text: getTranslated(context,'orderTime')+' :', children: [
                                    TextSpan(
                                        text: DateFormat('dd/MM/yyy hh:mm')
                                            .format(controller
                                                .prescriptions[index].dateTime),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            height: 1.5,
                                            color: Colors.black))
                                  ]),
                                ),
                                SizedBox(
                                  height: SizeConfig.defaultSize,
                                ),
                                /* Container(
                                 height: SizeConfig.defaultSize*8,
                                 width: SizeConfig.defaultSize*8,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(controller
                                              .prescriptions[index].img))),
                                ), */
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(
                                  TextSpan(text: getTranslated(context, 'status',)+' :', children: [
                                    TextSpan(
                                        text: getTranslated(context,controller
                                            .prescriptions[index].status),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            height: 1.5,
                                            color: Colors.black))
                                  ]),
                                ),
                                    /* Text(getTranslated(context, 'status',)+':',style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            height: 1.5,
                                            color: Colors.grey)),
                                    Text(getTranslated(context,controller
                                            .prescriptions[index].status)
                                        ,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            height: 1.5,
                                            color: Colors.black)), */
                                    FlatButton(
                                      child: CustomText(
                                        text: getTranslated(context, 'details'),
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        Get.bottomSheet(
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    margin: EdgeInsets.all(5),
                                                    height: 200,
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            .95,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Colors.blue),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                controller
                                                                    .prescriptions[
                                                                        index]
                                                                    .img),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text: 'Notes',
                                                        size: SizeConfig
                                                                .defaultSize *
                                                            1.8,
                                                      ),
                                                      Container(
                                                        child: CustomText(
                                                          text: controller
                                                              .prescriptions[
                                                                  index]
                                                              .notes,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: SizeConfig
                                                                .defaultSize *
                                                            1.5,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Address\n${controller.prescriptions[index].address.address}',
                                                      ),
                                                      SizedBox(
                                                        height: SizeConfig
                                                            .defaultSize,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: Colors.white,
                                            isDismissible: true,
                                            clipBehavior: Clip.antiAlias);
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.defaultSize,
                                ),
                              ],
                            ),
                          ),
                        ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: getTranslated(context,'addNewPresc'),
                  press: () {
                    Get.defaultDialog(
                        title: 'Add Prescription',
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(
                              color: kPrimaryColor,
                              height: 10,
                            ),
                            FlatButton(
                              child: Text('From Camera'),
                              onPressed: () async {
                                Get.back();
                                await controller.getImage(
                                    source: ImageSource.camera);

                                if (controller.prescImage != null) {
                                  Get.to(AddPrescription());
                                }
                              },
                            ),
                            Divider(
                              color: kPrimaryColor,
                              height: 10,
                            ),
                            FlatButton(
                              child: Text('From Gallery'),
                              onPressed: () async {
                                Get.back();
                                await controller.getImage(
                                    source: ImageSource.gallery);
                                if (controller.prescImage != null) {
                                  Get.to(AddPrescription());
                                }
                              },
                            ),
                            Divider(
                              color: kPrimaryColor,
                              height: 10,
                            ),
                            //FlatButton(child: Text('Cancel'),onPressed: (){},),
                          ],
                        ), //Divider(color: kPrimaryColor,height: 20,),
                        actions: [
                          Column(
                            children: [
                              FlatButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Get.back();
                                },
                              )
                            ],
                          )
                        ]);
                  },
                  radius: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
