import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField(@required this.HintText,
      {this.obscureText = false, this.onChanged});
  late final String HintText;
  final bool obscureText;
  var onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: HintText,
        hintStyle: TextStyle(
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.lightBlueAccent),
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
      ),
    );
  }
}
