import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/size_config.dart';

class InfoTextField extends StatelessWidget {
  final String initialValue;
  final String label;
  final String hint;
  final TextStyle hintStyle;
  final TextInputType inputType;
  final Function onFieldSubmitting;
  final Function onSave;
  UnderlineInputBorder outlineInputBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide(color: Colors.blue, width: 1));

  InfoTextField(
      {this.initialValue,
      this.hintStyle,
      this.inputType,
      this.label,
      this.hint,
      this.onFieldSubmitting,
      this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize,
          vertical: SizeConfig.defaultSize * 1.5),
      child: TextFormField(
        initialValue: initialValue,
        style: TextStyle(
            color: Colors.black, fontSize: SizeConfig.defaultSize * 2),
        keyboardType: inputType,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: hintStyle,
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            labelText: label),
        textInputAction: TextInputAction.next,
        onFieldSubmitted: onFieldSubmitting,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please provide a value,';
          }
          return null;
        },
        onSaved: onSave,
      ),
    );
  }
}
