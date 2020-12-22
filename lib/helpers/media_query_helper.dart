import 'package:flutter/material.dart';

class MQuery {
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static bool isVertical(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;
}
