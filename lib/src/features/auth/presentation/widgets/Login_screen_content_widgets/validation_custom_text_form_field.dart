import 'package:flutter/material.dart';

class ValidationCustomTextFormField extends StatelessWidget {
  final String textFeildLabel;
  final IconData textFieldIcon;
  final Function onSavedFunc;
  final Function validatorFunc;

  const ValidationCustomTextFormField({
    Key? key,
    required this.textFeildLabel,
    required this.textFieldIcon,
    required this.onSavedFunc,
    required this.validatorFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: Colors.teal),
        ),
        prefixIcon: Icon(
          textFieldIcon,
          color: Colors.white,
        ),
        label: Text(
          textFeildLabel,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
      ),
      onSaved: (value) {
        onSavedFunc(value);
      },
      validator: (value) {
        return validatorFunc(value);
      },
    );
  }
}
