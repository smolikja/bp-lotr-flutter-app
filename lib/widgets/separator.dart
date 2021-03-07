import 'package:flutter/material.dart';
import 'package:bp_flutter_app/helpers/constants.dart';

class Separator extends StatelessWidget {
  final double customHeight;
  final Color customColor;

  Separator({this.customHeight, this.customColor});

  double setHeight() {
    if (customHeight != null) {
      return customHeight;
    } else
      return 1;
  }

  Color setColor() {
    if (customColor != null) {
      return customColor;
    } else
      return kGreyDarkColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: setColor(),
      width: double.infinity,
      height: setHeight(),
    );
  }
}
