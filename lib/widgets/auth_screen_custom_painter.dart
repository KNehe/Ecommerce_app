import 'package:flutter/material.dart';

class AuthScreenCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xff56bfe5);
    path = Path();
    path.lineTo(size.width * 0.76, size.height * 0.68);
    path.cubicTo(size.width * 0.71, size.height * 0.67, size.width * 0.66,
        size.height * 0.64, size.width * 0.6, size.height * 0.6);
    path.cubicTo(size.width * 0.53, size.height * 0.55, size.width * 0.41,
        size.height * 0.43, size.width * 0.41, size.height * 0.4);
    path.cubicTo(size.width * 0.41, size.height * 0.39, size.width * 0.52,
        size.height * 0.27, size.width * 0.76, size.height * 0.18);
    path.cubicTo(size.width * 0.84, size.height * 0.15, size.width * 0.94,
        size.height * 0.18, size.width * 0.96, size.height * 0.18);
    path.cubicTo(size.width * 0.97, size.height * 0.17, size.width,
        size.height * 0.16, size.width, size.height * 0.16);
    path.cubicTo(size.width, size.height * 0.16, size.width, size.height * 0.57,
        size.width, size.height * 0.6);
    path.cubicTo(size.width, size.height * 0.63, size.width * 0.96,
        size.height * 0.66, size.width * 0.91, size.height * 0.68);
    path.cubicTo(size.width * 0.87, size.height * 0.69, size.width * 0.82,
        size.height * 0.69, size.width * 0.76, size.height * 0.68);
    path.cubicTo(size.width * 0.76, size.height * 0.68, size.width * 0.76,
        size.height * 0.68, size.width * 0.76, size.height * 0.68);
    canvas.drawPath(path, paint);

    // Path number 2

    paint.color = Color(0xff4b515a);
    path = Path();
    path.lineTo(0, size.height * 0.8);
    path.cubicTo(0, size.height * 0.8, size.width * 0.13, size.height,
        size.width * 0.27, size.height);
    path.cubicTo(size.width * 0.41, size.height, size.width * 0.43,
        size.height * 0.9, size.width * 0.48, size.height * 0.75);
    path.cubicTo(size.width * 0.51, size.height * 0.67, size.width * 0.51,
        size.height * 0.61, size.width * 0.63, size.height * 0.51);
    path.cubicTo(size.width * 0.77, size.height * 0.38, size.width,
        size.height * 0.28, size.width, size.height * 0.23);
    path.cubicTo(size.width, size.height * 0.17, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width * 0.4, 0, size.width * 0.4, 0);
    path.cubicTo(size.width * 0.4, 0, 0, size.height / 3, 0, size.height / 3);
    path.cubicTo(
        0, size.height / 3, 0, size.height * 0.8, 0, size.height * 0.8);
    canvas.drawPath(path, paint);

    // Path number 3

    paint.color = Color(0xfffead40);
    path = Path();
    path.lineTo(0, 0);
    path.cubicTo(0, 0, size.width * 0.57, 0, size.width * 0.57, 0);
    path.cubicTo(size.width * 0.57, 0, size.width * 0.56, size.height * 0.04,
        size.width * 0.43, size.height * 0.06);
    path.cubicTo(size.width * 0.29, size.height * 0.07, size.width / 4,
        size.height * 0.12, size.width * 0.19, size.height * 0.3);
    path.cubicTo(size.width * 0.13, size.height * 0.48, 0, size.height / 2, 0,
        size.height / 2);
    path.cubicTo(0, size.height / 2, 0, 0, 0, 0);
    canvas.drawPath(path, paint);

    // // Path number 1

    // paint.color = Color(0xff4b515a).withOpacity(1);
    // path = Path();
    // path.lineTo(0, size.height * 0.86);
    // path.cubicTo(0, size.height * 0.86, size.width * 0.14, size.height,
    //     size.width * 0.28, size.height);
    // path.cubicTo(size.width * 0.42, size.height, size.width * 0.51,
    //     size.height * 0.96, size.width * 0.54, size.height * 0.88);
    // path.cubicTo(size.width * 0.57, size.height * 0.8, size.width * 0.54,
    //     size.height * 0.69, size.width * 0.62, size.height * 0.59);
    // path.cubicTo(size.width * 0.7, size.height / 2, size.width, size.height / 4,
    //     size.width, size.height * 0.19);
    // path.cubicTo(size.width, size.height * 0.13, size.width, 0, size.width, 0);
    // path.cubicTo(size.width, 0, size.width * 0.4, 0, size.width * 0.4, 0);
    // path.cubicTo(
    //     size.width * 0.4, 0, 0, size.height * 0.35, 0, size.height * 0.35);
    // path.cubicTo(
    //     0, size.height * 0.35, 0, size.height * 0.86, 0, size.height * 0.86);
    // canvas.drawPath(path, paint);

    // // Path number 2

    // paint.color = Color(0xfffead40).withOpacity(1);
    // path = Path();
    // path.lineTo(0, 0);
    // path.cubicTo(0, 0, size.width * 0.57, 0, size.width * 0.57, 0);
    // path.cubicTo(size.width * 0.57, 0, size.width * 0.56, size.height * 0.04,
    //     size.width * 0.43, size.height * 0.06);
    // path.cubicTo(size.width * 0.29, size.height * 0.08, size.width / 4,
    //     size.height * 0.12, size.width * 0.19, size.height * 0.3);
    // path.cubicTo(size.width * 0.13, size.height * 0.49, 0, size.height * 0.51,
    //     0, size.height * 0.51);
    // path.cubicTo(0, size.height * 0.51, 0, 0, 0, 0);
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
