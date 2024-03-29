import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF161220);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle =TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5
);

const defaultDuration =Duration(milliseconds:250 );

final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9]+.[a-zA-Z]");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNameNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}

final String tableCartProduct='cartProduct';
final String columnName='name';
final String columnImage='image';
final String columnQuantity='quantity';
final String columnPrice='price';
final String columnproductId='productId';
final String columnRating='currentRating';

final String CACHED_USER_DATA='CACHED_USER_DATA';
enum Status{
  inProcess,shipped,delivered,returned
}