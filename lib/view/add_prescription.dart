import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safwat_pharmacy/core/view_model/map_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/prescription_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/models/address_model.dart';
import 'package:safwat_pharmacy/models/prescription_model.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';
import 'package:safwat_pharmacy/view/select_address.dart';

class AddPrescription extends StatelessWidget {
  final PrescriptionViewModel prescController = Get.find();
  final MapViewModel addressController = Get.find();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String notes = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Add Prescription',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<PrescriptionViewModel>(
              init: Get.find(),
              builder: (controller) => Stack(children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      height: SizeConfig.defaultSize * 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.blue),
                          image: DecorationImage(
                              image: FileImage(controller.prescImage),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 2,
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
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
                              ],
                            ),
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
                      text: 'Retake Photo',
                      radius: 5,
                    ),
                  ),
                )
              ]),
            ),
            Form(
              key: globalKey,
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.teal)),
                child: TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: 25, left: 10, right: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: 'Notes',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none, gapPadding: 10),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  onSaved: (value) {
                    notes = value;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Address',
                    size: SizeConfig.defaultSize * 1.8,
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: kPrimaryColor,
                      ),
                      title: GetBuilder<MapViewModel>(
                        init: Get.find(),
                        builder: (controller) => CustomText(
                          text: controller
                              .addresses[controller.defaultIndex].address,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Get.to(SelectAddress());
                        },
                        child: CustomText(
                          text: 'Edit',
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 2,
                  ),
                  CustomButton(
                    text: 'Send',
                    press: ()async {
                      globalKey.currentState.save();
                      await prescController.uploadImage();
                      prescController.addPrescription(PrescriptionModel(
                        address: addressController.addresses[addressController.defaultIndex],
                        dateTime: DateTime.now(),
                        img: prescController.currentImageUrl,
                        notes: notes,
                        status: 'InProcess'
                      ));
                      Get.back();
                    

                    },
                    radius: 5,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
