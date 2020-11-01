import 'package:flutter/material.dart';

class UnderlinedText extends StatelessWidget {
  final String text;
  final double decorationThickness;
  final FontWeight fontWeight;
  final double fontSize;

  const UnderlinedText(
      {Key key,
      @required this.text,
      this.decorationThickness,
      this.fontWeight,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.underline,
        decorationThickness: decorationThickness,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
