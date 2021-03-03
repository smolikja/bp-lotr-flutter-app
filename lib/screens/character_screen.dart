import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';

class CharacterScreen extends BaseStatefulWidget {
  CharacterScreen({
    Key key,
    @required Function(Widget) fullscreenPush,
  }) : super(key: key, fullscreenPush: fullscreenPush);

  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Character",
        fullscreenPush: widget.fullscreenPush,
      ),
      body: SingleChildScrollView(child: Text("Character")),
    );
  }
}
