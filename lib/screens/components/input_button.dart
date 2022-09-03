import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  InputButton({required this.ButtonText, required this.onPressed});
  late final String ButtonText;
  var onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 5.0,
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            ButtonText,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
