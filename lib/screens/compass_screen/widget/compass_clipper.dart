import 'package:flutter/cupertino.dart';

class CompassClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();
    path.addOval(
      Rect.fromCenter(
          height: height - 50,
          width: width - 50,
          center: Offset(width / 2, height / 2)),
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
