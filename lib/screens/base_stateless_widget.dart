import 'package:flutter/material.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  BaseStatelessWidget({Key key, @required this.fullscreenPush})
      : assert(fullscreenPush != null);

  final Function(Widget) fullscreenPush;
}
