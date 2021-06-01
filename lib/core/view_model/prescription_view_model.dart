import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safwat_pharmacy/models/address_model.dart';
import 'package:safwat_pharmacy/models/prescription_model.dart';

class PrescriptionViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  List<PrescriptionModel> get prescriptions => _prescriptions;
  List<PrescriptionModel> _prescriptions = [];
  CollectionReference _prescRef =
      FirebaseFirestore.instance.collection('prescriptions');
  String userId = FirebaseAuth.instance.currentUser.uid;
  File get prescImage => _prescImage;
  File _prescImage;
  final picker = ImagePicker();
  String get currentImageUrl => _currentPrescUrl;
  String _currentPrescUrl;
  String oldUrl;

  @override
  void onInit() {
    getPrescriptions();
    super.onInit();
  }

 
  Future<List<PrescriptionModel>> getPrescriptions() async {
    List<PrescriptionModel> _loadedPrescriptions = [];
    _loading.value = true;
    var userPresc = await _prescRef.doc(userId).get().then((result) {
      if (result.data() != null) {
        var extractedData = result.data();
        print(extractedData.length);
        extractedData.forEach((prescId, prescData) => _loadedPrescriptions.add(
              PrescriptionModel(
                id: prescId,
                address: AddressModel(
                  address: prescData['address']['address'],
                  details: prescData['address']['details'],
                  id: prescData['address']['id'],
                  mobile: prescData['address']['mobile'],
                  name: prescData['address']['name'],
                ),
                dateTime: DateTime.parse(prescData['dateTime']),
                img: prescData['img'],
                notes: prescData['notes'],
                status: prescData['status'],
              ),
            ));
      }
    });
    _prescriptions = _loadedPrescriptions.reversed.toList();
    update();
    _loading.value = false;
  }

  Future<void> addPrescription(PrescriptionModel prescription) async {
    _loading.value = true;
    String dateTime = DateTime.now().toString();
    String prescId = userId.substring(0, 5) +
        dateTime.substring(0, 4) +
        dateTime.substring(5, 7) +
        dateTime.substring(8, 10) +
        dateTime.substring(20);
    Map<String, dynamic> newPrescription = {
      'address': {
        'address': prescription.address.address,
        'details': prescription.address.details,
        'mobile': prescription.address.mobile,
        'name': prescription.address.name,
      },
      'id': prescId,
      'img': prescription.img,
      "dateTime": prescription.dateTime.toString(),
      'status': 'InProcess',
      'notes': prescription.notes
    };
    await _prescRef
        .doc(userId)
        .set({prescId: newPrescription}, SetOptions(merge: true));

    /*  var presc = PrescriptionModel(
      address: prescription.address,
      dateTime: DateTime.now(),
      id: prescId,
      img: prescription.img,
      notes: prescription.notes
    ); */

    _prescriptions.insert(0, prescription);
    update();
    _loading.value = false;
  }

  Future<void> getImage({ImageSource source}) async {
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      _prescImage = File(pickedImage.path);
    } else {
      Get.snackbar('No Image', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM);
    }
    update();
  }

  Future uploadImage() async {
    String _filePath = DateTime.now().toString() + '_image.jpg';

    try {
      _loading.value = true;
      var uploadTask =
          await FirebaseStorage.instance.ref().child(_filePath).putFile(_prescImage);
      String url = await uploadTask.ref.getDownloadURL();
      _currentPrescUrl=url;
    
      print('uuuuuuuuuuuu'+url);
      update();
      _loading.value = false;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> deleteImage() async {
    if (oldUrl != null) {
      String fileUrl = Uri.decodeFull(Path.basename(oldUrl))
          .replaceAll(new RegExp(r'(\?alt).*'), '');

      var photoRef = await FirebaseStorage.instance.ref();
      photoRef.child(fileUrl).delete();
    }
    //await FirebaseStorage.instance.ref().
  }

  Future saveImage(String imgUrl,) async {
    DocumentReference user =
        FirebaseFirestore.instance.collection('prescriptions').doc(userId);
    await user.set({'img': imgUrl}, SetOptions(merge: true));
  }
}
