import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/models/address_model.dart';

class MapViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  int defaultIndex = 0;
  List<AddressModel> get addresses => _addresses;
  List<AddressModel> _addresses = [];
  Set<Marker> myMarker = {};
  String currentAddress = 'Cairo';
  String userId = FirebaseAuth.instance.currentUser.uid;
  Position get currentLocation => _currentLocation;
  Position _currentLocation = Position();
  CollectionReference addressRef =
      FirebaseFirestore.instance.collection('addresses');
  MapViewModel() {
    getAddresses();
  }

  getCurrentAddress() async {
    try {
      final coordinates =
          Coordinates(_currentLocation.latitude, _currentLocation.longitude);
      var address =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      currentAddress =
          '${address.first.locality} ${address.first.postalCode != null ? address.first.postalCode : ''} ${address.first.subAdminArea} ${address.first.adminArea} ';
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAddresses() async {
    _loading.value = true;
    List<AddressModel> _loadedAddresses = [];
    var addresses = await addressRef.doc(userId).get().then((result) {
      if (result.data() != null) {
        var data = result.data();
        data.forEach((addressId, addressData) {
          _loadedAddresses.add(AddressModel(
              id: addressId,
              address: addressData['address'],
              details: addressData['details'],
              mobile: addressData['mobile'],
              name: addressData['name']));
        });
      }
    });
    _addresses = _loadedAddresses;
    update();
    _loading.value = false;
  }

  addMarker() {
    myMarker.add(Marker(
        markerId: MarkerId('locatin'),
        position:
            //LatLng(_currentLocation.latitude, _currentLocation.longitude)
            LatLng(30.033333, 31.233334)));
  }

  cameraMove(CameraPosition pos) {
    _currentLocation = Position(
        latitude: pos.target.latitude, longitude: pos.target.longitude);
    update();
    getCurrentAddress();
  }

  Future<Position> getCurrentLocation(
      Completer<GoogleMapController> mapController) async {
    final GoogleMapController controller = await mapController.future;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position pos) {
      _currentLocation = pos;

      print(_currentLocation.latitude);
    });
    update();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        zoom: 15)));
    await getCurrentAddress();
    print('addddd:$currentAddress');
  }

  saveAddress({AddressModel address}) async {
    String id = DateTime.now().toString().substring(20);
    if ((_addresses.singleWhere((add) => add.address == address.address,
            orElse: () => null)) ==
        null) {
      await addressRef.doc(userId).set({
        id: {
          'id': id,
          'address': address.address,
          'details': address.details,
          'name': address.name,
          'mobile': address.mobile
        }
      }, SetOptions(merge: true));
      _addresses.add(AddressModel(
          id: id,
          address: address.address,
          details: address.details,
          mobile: address.mobile,
          name: address.name));
      update();
    } else {
      print(address.id);
      await addressRef.doc(userId).update({
        address.id: {
          'id': address.id,
          'address': address.address,
          'details': address.details,
          'name': address.name,
          'mobile': address.mobile
        }
      });
      _addresses[_addresses.indexWhere((add) => add.id == address.id)] =
          address;
      update();
    }
  }

  deleteAddress(AddressModel selectedAddress) async {
    await addressRef
        .doc(userId)
        .update({selectedAddress.id: FieldValue.delete()});
    _addresses.remove(selectedAddress);
    update();
  }

  changeAddressIndex(int value) {
    defaultIndex = value;
    update();
  }
}
