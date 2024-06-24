import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  const VerticalSpace(
    this.height, {
    super.key,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
