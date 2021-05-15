import 'package:get/get.dart';

class ControlViewModel extends GetxController{
int _navigatorIndex=0;

get navigatorIndex=>_navigatorIndex;


void changeSelectedIndex(int selectedIndex){
  _navigatorIndex=selectedIndex;
  update();
}
}