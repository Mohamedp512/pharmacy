import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/auth_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/auth/login_screen.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';

class SignUpScreen extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  AuthViewModel _authController=Get.put(AuthViewModel());
//  String name,email,password;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(defaultSize * 3),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.defaultSize * 3,
              ),
              CustomText(
                text: 'Sign Up',
                size: defaultSize * 2,

                //fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: defaultSize * 3,
              ),
              CustomText(
                text: 'Register Account',
                size: defaultSize * 3,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: defaultSize,
              ),
              Text(
                'Complete your details and create an account',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: defaultSize * 8,
              ),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        _authController.name=value;                        
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {},
                      decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your full name',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.person)),
                    ),
                    SizedBox(
                      height: defaultSize * 3,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        _authController.email = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {},
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.email_outlined)),
                    ),
                    SizedBox(
                      height: defaultSize * 3,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        _authController.password = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password';
                        }
                      },
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {},
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: "Enter your password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.lock_outlined)),
                    ),
                    SizedBox(
                      height: defaultSize * 2,
                    ),
                    /* Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {},
                          activeColor: kPrimaryColor,
                        ),
                        Text('Remember me'),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forget Password',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ), */
                  ],
                ),
              ),
              SizedBox(
                height: defaultSize * 5,
              ),
              CustomButton(
                text: 'SIGN UP',
                press: () {
                 
                  if(_globalKey.currentState.validate()){
                     _globalKey.currentState.save();
                    controller.creatAccountWitEmailAndPassword();
                  }
                },
              ),
              SizedBox(
                height: defaultSize * 2,
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Have an account?'),
                  FlatButton(
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}