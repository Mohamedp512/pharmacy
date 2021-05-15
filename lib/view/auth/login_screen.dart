import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/auth_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/auth/signup_screen.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';
import 'package:safwat_pharmacy/view/custom_widgets/social_card.dart';

class LoginScreen extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
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
                text: 'Sign In',
                size: defaultSize * 2,

                //fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: defaultSize * 3,
              ),
              CustomText(
                text: 'Welcome Back',
                size: defaultSize * 3,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: defaultSize,
              ),
              Text(
                'Sign in with email and password or continue with social media',
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
                      onSaved: (Value) {
                        controller.email = Value;
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
                        controller.password = value;
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
                    Row(
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: defaultSize * 5,
              ),
              CustomButton(
                text: 'SIGN IN',
                press: () {
                  _globalKey.currentState.save();
                  if(_globalKey.currentState.validate()){
                    controller.signInWitEmailAndPassword();
                  }
                },
              ),
              SizedBox(
                height: defaultSize * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    press: () {
                      controller.googleSignInMethod();
                    },
                    icon: 'assets/icons/google-icon.svg',
                  ),
                  SocialCard(
                    press: () {
                      controller.facebookLoginMethod();
                    },
                    icon: 'assets/icons/facebook-2.svg',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?'),
                  FlatButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    onPressed: () {
                      Get.to(SignUpScreen());
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
