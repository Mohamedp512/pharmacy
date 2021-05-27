import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safwat_pharmacy/core/view_model/map_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/profile_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/save_address.dart';

import 'custom_widgets/custom_text.dart';

class AddAddressView extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();
  final ProfileViewModel profileController = Get.find();
  final MapViewModel mapController = Get.find();
  static final CameraPosition _kCairo = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 14.4746,
  );

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  GetBuilder<MapViewModel>(
                    init: Get.find(),
                    builder: (controller) => GoogleMap(
                      onCameraMove: (CameraPosition pos) {
                        controller.cameraMove(pos);
                      },
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      initialCameraPosition: _kCairo,
                      onMapCreated: (GoogleMapController contr) {
                        _controller.complete(contr);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: EdgeInsets.all(SizeConfig.defaultSize),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    height: SizeConfig.defaultSize * 7,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: SizeConfig.defaultSize * 0.5,
                        ),
                        GetBuilder<MapViewModel>(
                            init: Get.find(),
                            builder: (controller) => Expanded(
                                    child: Container(
                                        child: CustomText(
                                  text: controller.currentAddress,
                                  size: SizeConfig.defaultSize * 1.7,
                                )))),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.location_on,
                      color: kPrimaryColor,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: GetBuilder<MapViewModel>(
                          init: Get.find(),
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              controller.getCurrentLocation(_controller);
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.my_location),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CustomButton(
              text: 'Confirm Location'.toUpperCase(),
              press: ()async {
                var response=await Get.to(SaveAddress(
                  address: mapController.currentAddress,
                  details: '',
                  mobile: profileController.user.mobile,
                  name: profileController.user.name,
                ));
                if (response=='edit'){
                  Get.back();
                }
              },
              radius: 5,
            ),
          )
        ],
      ),
    );
  }
}
