import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/costants.dart';


class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;

  /* _errorMsg(String str){
    switch (hint){
      case 'Enter your Name':return 'Name is Empty';
      case 'Enter your Email': return 'Email is Empty';
      case 'Enter Your Password': return 'Password is empty';
    }
  } */


  CustomTextField({@required this.onClick, @required this.hint,@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        //height: MediaQuery.of(context).size.height * .09,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: kPrimaryColor,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(2, 3))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          onSaved:onClick ,
          obscureText: hint=='Enter Your Password'? true:false,
          /* validator: (value){
            if(value.isEmpty){
              return _errorMsg(hint);
            }
          }, */
          decoration: InputDecoration(
            focusColor: kPrimaryColor,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              icon: Icon(icon,color: kPrimaryColor,),
              hintText: hint
          ),
        ), ),
    );
  }
}
