import 'package:flutter/material.dart';

const kTextButtonStyle = TextStyle(
  fontSize: 18.0,
);

class RoundedButton extends StatelessWidget {
  RoundedButton({this.label, @required this.onPressed, this.color});

  final Color color;
  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: this.color,
        borderRadius: BorderRadius.circular(22),
        child: MaterialButton(
          onPressed: this.onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            this.label,
            style: kTextButtonStyle,
          ),
        ),
      ),
    );
  }
}
