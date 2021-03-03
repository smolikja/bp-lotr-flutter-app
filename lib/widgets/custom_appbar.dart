import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateless_widget.dart';
import 'package:bp_flutter_app/screens/about_screen.dart';

class CustomAppBar extends BaseStatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  CustomAppBar({
    Key key,
    this.title,
    @required Function(Widget) fullscreenPush,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key, fullscreenPush: fullscreenPush);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      actions: [
        InkWell(
          onTap: () {
            fullscreenPush(AboutScreen(fullscreenPush: fullscreenPush));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.info_outline_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
