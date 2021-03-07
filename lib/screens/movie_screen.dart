import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';
import 'package:bp_flutter_app/models/movies_model.dart';

class MovieScreen extends BaseStatefulWidget {
  final String movieId;
  final String title;

  MovieScreen({Key key, @required Function(Widget) fullscreenPush, @required this.movieId, @required this.title})
      : super(key: key, fullscreenPush: fullscreenPush);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        fullscreenPush: widget.fullscreenPush,
      ),
      body: SingleChildScrollView(child: Text("Movie")),
    );
  }
}
