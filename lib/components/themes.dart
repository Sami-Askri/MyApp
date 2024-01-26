import 'package:flutter/material.dart';

class Grad {
  static BoxDecoration gradientDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}

class Gris {
  static BoxDecoration gris() {
    return BoxDecoration(
      color: Color.fromARGB(255, 53, 56, 51),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Color.fromARGB(255, 53, 56, 51);
    canvas.drawPath(mainBackground, paint);

    Path lines = Path();
    lines.moveTo(width * 0.7, 0);
    lines.quadraticBezierTo(width * 0.05, height * 0.25, 0, height * 0.2);
    paint.color = Color.fromARGB(255, 41, 37, 37);
    canvas.drawPath(lines, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
