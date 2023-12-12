import 'package:flutter/material.dart';

class DottedBorder extends StatelessWidget {
  final Widget child;

  DottedBorder({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedPainter(),
      child: child,
    );
  }
}

class DottedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Set your desired border color here
      ..strokeWidth = 1 // Set the width of the border line
      ..style = PaintingStyle.stroke;

    const dashWidth = 5; // Width of each dash
    const dashSpace = 3; // Space between dashes
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}