import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';
import 'package:bp_flutter_app/widgets/list_divider.dart';
import 'package:bp_flutter_app/models/movies_model.dart';
import 'package:bp_flutter_app/globals.dart';
import 'package:bp_flutter_app/helpers/constants.dart';

class MoviesListScreen extends BaseStatefulWidget {
  MoviesListScreen({
    Key key,
    @required Function(Widget) fullscreenPush,
  }) : super(key: key, fullscreenPush: fullscreenPush);

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  MoviesModel _moviesData;

  @override
  void initState() {
    super.initState();
    _moviesData = globalMovies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context).translate('appbar_movies_list'),
        fullscreenPush: widget.fullscreenPush,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => ListDivider(indent: 16.0),
              itemCount: _moviesData.docs.length,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    onTap: () {
                      // _onItemTap(items[index].fullscreen, items[index].screen);
                    },
                    title: Text(_moviesData.docs[index].name,
                        style: TextStyle(color: kPrimaryColor, fontSize: 14.0, fontWeight: FontWeight.bold)),
                    // leading: items[index].icon,
                    trailing: Icon(Icons.keyboard_arrow_right, color: kGreyLightColor, size: 24),
                    dense: true,
                  ),
                );
              },
            ),
            // FutureBuilder<String>(
            //     future: _versionFuture,
            //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError && snapshot.data != null) {
            //         return GestureDetector(
            //           child: Container(
            //             alignment: Alignment.center,
            //             width: double.infinity,
            //             padding: EdgeInsets.only(top: 8, bottom: 16),
            //             child: Text(
            //               snapshot.data,
            //               style: TextStyle(color: kGreyLightColor, fontSize: 14),
            //             ),
            //           ),
            //           onDoubleTap: _switchTestTopicSubscription,
            //         );
            //       }
            //       return Container();
            //     }),
          ],
        ),
      ),
    );
  }
}
