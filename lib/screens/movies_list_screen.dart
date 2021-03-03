import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';

class MoviesListScreen extends BaseStatefulWidget {
  MoviesListScreen({
    Key key,
    @required Function(Widget) fullscreenPush,
  }) : super(key: key, fullscreenPush: fullscreenPush);

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context).translate('appbar_movies_list'),
        fullscreenPush: widget.fullscreenPush,
      ),
      body: SingleChildScrollView(child: Text("Movies list")),
    );
  }
}
