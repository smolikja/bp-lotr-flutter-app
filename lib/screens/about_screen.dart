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
  List<String> _rows = [
    "Guess quote's character!",
    "school project",
    "fun made by Jakub Smolik",
    "smolikja@protonmail.com",
    "LOTR data credits: https://the-one-api.dev/"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context).translate('appbar_about'),
        fullscreenPush: widget.fullscreenPush,
        hideAbout: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Column(
          children: [_getTextWidgets(_rows)],
        )),
      ),
    );
  }

  Widget _getTextWidgets(List<String> strings) {
    return new Column(
        children: strings.map((item) => new Padding(padding: const EdgeInsets.all(16.0), child: Text(item))).toList());
  }
}
