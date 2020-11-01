import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color iconColor;
  final IconData iconData;
  final Function onPressed;

  RoundIconButton({
    @required this.width,
    @required this.height,
    @required this.backgroundColor,
    @required this.iconColor,
    @required this.iconData,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Material(
        borderRadius: BorderRadius.circular(50),
        color: backgroundColor,
        child: IconButton(
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
