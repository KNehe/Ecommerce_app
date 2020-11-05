import 'package:flutter/material.dart';

class RoundCartButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  const RoundCartButton({
    Key key,
    @required this.onTap,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          icon,
          color: Colors.red,
        ),
      ),
    );
  }
}
