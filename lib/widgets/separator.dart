import 'package:flutter/material.dart';
import 'package:bp_flutter_app/helpers/constants.dart';

class Separator extends StatelessWidget {
  final double customHeight;

  Separator({this.customHeight});

  double setHeight() {
    if (customHeight != null) {
      return customHeight;
    } else
      return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGreyDarkColor,
      width: double.infinity,
      height: setHeight(),
    );
  }
}
