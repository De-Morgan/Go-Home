import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: CircularProgressIndicator(),
    );
  }
}
