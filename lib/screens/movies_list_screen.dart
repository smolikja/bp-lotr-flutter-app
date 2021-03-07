import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';
import 'package:bp_flutter_app/widgets/list_divider.dart';
import 'package:bp_flutter_app/models/movies_model.dart';
import 'package:bp_flutter_app/globals.dart';
import 'package:bp_flutter_app/helpers/constants.dart';
import 'package:bp_flutter_app/screens/movie_screen.dart';

class MoviesListScreen extends BaseStatefulWidget {
  MoviesListScreen({
    Key key,
    @required Function(Widget) fullscreenPush,
  }) : super(key: key, fullscreenPush: fullscreenPush);

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  List<Movie> _moviesData;
  Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = _getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context).translate('appbar_movies_list'),
        fullscreenPush: widget.fullscreenPush,
      ),
      body: FutureBuilder<List<Movie>>(
        future: _moviesFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _moviesData = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => ListDivider(indent: 16.0),
                  itemCount: _moviesData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MovieScreen(fullscreenPush: widget.fullscreenPush, movie: _moviesData[index])));
                        },
                        title: Text(_moviesData[index].name,
                            style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold)),
                        // leading: items[index].icon,
                        trailing: Icon(Icons.keyboard_arrow_right, color: kGreyLightColor, size: 24),
                        dense: true,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<List<Movie>> _getMovies() async {
    return globalMovies.docs;
  }
}
