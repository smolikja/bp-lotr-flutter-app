import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';

class AboutScreen extends BaseStatefulWidget {
  AboutScreen({
    Key key,
    @required Function(Widget) fullscreenPush,
  }) : super(key: key, fullscreenPush: fullscreenPush);

  @override
  _AboutScreenScreenState createState() => _AboutScreenScreenState();
}

class _AboutScreenScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context).translate('appbar_about'),
        fullscreenPush: widget.fullscreenPush,
        hideAbout: true,
      ),
      body: SingleChildScrollView(child: Text("About")),
    );
  }
}
