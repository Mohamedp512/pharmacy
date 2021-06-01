import 'package:safwat_pharmacy/models/address_model.dart';

class PrescriptionModel {
  String id;
  String img;
  String notes;
  DateTime dateTime;
  AddressModel address;
  String status;

  PrescriptionModel({
    this.id,
    this.img,
    this.notes,
    this.dateTime,
    this.address,
    this.status,
  });
}
