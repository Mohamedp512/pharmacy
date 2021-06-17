import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/control_view.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';

class SplashView extends StatefulWidget {
  
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animationLogoIn;
  Animation<double>_animationLogoUp;
  @override
  void initState() {
   
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animationLogoIn =Tween(begin: 20.0,end: 1.0).animate (CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.25),
    ));
    
     _animationLogoUp = CurvedAnimation(
       parent: _animationController,
       curve: Interval(0.30,0.50)
     );
      _animationController.forward();

    _animationController.addStatusListener((status){
      if(status==AnimationStatus.completed){
        Get.offAll(ControlView());
      }
    });
    
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
    SizeConfig().init(context);
    return GestureDetector(
      onTap: (){_animationController.forward(from: 0);},
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) => Scaffold(
          backgroundColor: kPrimaryColor,
          body: Stack(
            alignment: Alignment.center,
            children: [
              // Positioned(child:Container(width: SizeConfig.screenWidth,),),

              Positioned(
                  top: MediaQuery.of(context).size.height / 2,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Opacity(
                        opacity: _animationLogoUp.value,
                        child: Column(children: [Text(
                          'Safwat',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Text(
                          'Pharmacy',
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        )],),
                      )
                    ],
                  )),
              Positioned(
                top: MediaQuery.of(context).size.height / 2.5-50*_animationLogoUp.value,
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: _animationLogoIn.value,
                  child: Image.asset(
                    'assets/images/pharmaLogo.png',
                    fit: BoxFit.contain,
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
