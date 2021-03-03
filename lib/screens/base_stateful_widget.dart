import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  BaseStatefulWidget({Key key, @required this.fullscreenPush})
      : assert(fullscreenPush != null);

  final Function(Widget) fullscreenPush;
}
