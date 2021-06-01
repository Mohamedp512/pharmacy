import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/account_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/auth_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/cart_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/control_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/home_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/map_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/order_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/prescription_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/profile_view_model.dart';
import 'package:safwat_pharmacy/helper/local_storage_data.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => ProfileViewModel());
    Get.lazyPut(() => LocalStoreageData());
    Get.lazyPut(() => AccountViewModel());
    Get.lazyPut(() => OrderViewModel());
    //Get.lazyPut(()=>LocalStoreageData());
    Get.lazyPut(() => MapViewModel());
    Get.lazyPut(() => PrescriptionViewModel());
  }
}
