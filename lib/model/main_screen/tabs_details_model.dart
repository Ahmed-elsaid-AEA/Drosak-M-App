import 'package:flutter/material.dart';

class TabsDetailsModel {
  final String text;
  final String imageIconSvg;
  final Widget screen;

  const TabsDetailsModel({
    required this.text,
    required this.screen,
    required this.imageIconSvg,
  });
}
