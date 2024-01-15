import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    drawContainer(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void drawContainer(Canvas canvas, Size size) {
    const double radius = 12;
    const double padding = 10;
    final linePaint = Paint()
      ..color = Colors.white.withAlpha(50)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    // corners
    var topLeft = const Offset(padding, padding);
    var topRight = Offset(size.width - padding, padding);
    var botRight = Offset(size.width - padding, size.height - padding);
    var botLeft = Offset(padding, size.height - padding);
    final borderPath = Path()
      ..moveTo(topLeft.dx + radius, topLeft.dy)
      ..lineTo(topRight.dx - radius, topRight.dy)
      ..quadraticBezierTo(
          topRight.dx, topRight.dy, topRight.dx, topRight.dy + radius)
      ..lineTo(botRight.dx, botRight.dy - radius)
      ..quadraticBezierTo(
          botRight.dx, botRight.dy, botRight.dx - radius, botRight.dy)
      ..lineTo(botLeft.dx + radius, botLeft.dy)
      ..quadraticBezierTo(
          botLeft.dx, botLeft.dy, botLeft.dx, botLeft.dy - radius)
      ..lineTo(topLeft.dx, topLeft.dy + radius)
      ..quadraticBezierTo(
          topLeft.dx, topLeft.dy, topLeft.dx + radius, topLeft.dy);
    // canvas.drawRect(rect, linePaint);
    canvas.drawPath(borderPath, linePaint);
  }
}
