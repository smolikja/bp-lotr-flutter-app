import 'package:flutter/material.dart';

class Phoenix extends StatefulWidget {
  Phoenix({this.child});

  final Widget child;

  static void rebirth(BuildContext context) {
    context.findAncestorStateOfType<_PhoenixState>().rebirth();
  }

  @override
  _PhoenixState createState() => _PhoenixState();
}

class _PhoenixState extends State<Phoenix> {
  Key key = UniqueKey();

  void rebirth() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: KeyedSubtree(
        key: key,
        child: widget.child,
      ),
    );
  }
}
