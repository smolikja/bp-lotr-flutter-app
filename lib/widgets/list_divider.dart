import 'package:flutter/material.dart';
import 'package:bp_flutter_app/helpers/constants.dart';

class ListDivider extends StatelessWidget {
  final double indent;

  ListDivider({this.indent});

  @override
  Widget build(BuildContext context) {
    return Divider(color: kPrimaryColor, height: 1.0, indent: indent ?? 0, endIndent: indent ?? 0);
  }
}
