import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/view/custom_widgets/control_view.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: 1,
      upperBound: 10
    );
    _animationController.addStatusListener((status){
      if(status==AnimationStatus.completed){
        Get.to(ControlView());
      }
    });
    _animationController.forward();
    //Future.delayed(Duration(seconds: 3)).then((value)=>Get.to(ControlView()));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ScaleTransition(
        scale: _animationController,

        child: Center(
          child: FlutterLogo(
            size: 40,
          ),
        ),
      ),
    );
  }
}
