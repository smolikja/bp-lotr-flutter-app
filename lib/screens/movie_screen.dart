import 'package:bp_flutter_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';
import 'package:bp_flutter_app/models/movies_model.dart';
import 'package:bp_flutter_app/models/quotes_model.dart';
import 'package:bp_flutter_app/widgets/list_divider.dart';
import 'package:bp_flutter_app/widgets/character_list_tile.dart';
import 'package:bp_flutter_app/widgets/separator.dart';
import 'package:bp_flutter_app/widgets/movie_info_widget.dart';
import 'package:flutter/services.dart';

import 'package:bp_flutter_app/services/app_localizations.dart';

class MovieScreen extends BaseStatefulWidget {
  final Movie movie;

  MovieScreen({Key key, @required Function(Widget) fullscreenPush, @required this.movie})
      : super(key: key, fullscreenPush: fullscreenPush);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  Future<List<Quote>> _quotesFuture;
  List<Quote> _quoteData;
  ScrollController _scrollController = ScrollController();
  int _quotesToShow = 10;

  @override
  void initState() {
    super.initState();
    _quotesFuture = _getQuotes();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: widget.movie.name,
          fullscreenPush: widget.fullscreenPush,
        ),
        body: FutureBuilder<List<Quote>>(
          future: _quotesFuture,
          builder: (BuildContext context, AsyncSnapshot<List<Quote>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            _quoteData = snapshot.data.take(_quotesToShow).toList();

            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MovieInfoWidget(movie: widget.movie),
                  Separator(),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => ListDivider(indent: 16.0),
                    itemCount: _quoteData.length,
                    itemBuilder: (context, index) {
                      if (_quoteData[index].dialog.isNotEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                                child: GestureDetector(
                                  child: Text(_quoteData[index].dialog),
                                  onLongPress: () {
                                    Clipboard.setData(new ClipboardData(text: _quoteData[index].dialog)).then((_) {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(AppLocalizations.of(context).translate("quote_copy_text")),
                                        duration: Duration(seconds: 1),
                                      ));
                                    });
                                  },
                                ),
                              ),
                            ),
                            CharacterListTile(
                                fullscreenPush: widget.fullscreenPush, characterId: _quoteData[index].character)
                          ],
                        );
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }

  Future<List<Quote>> _getQuotes() async {
    return globalQuotes.docs.where((quote) => quote.movie == widget.movie.id).toList()..shuffle();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < _quotesToShow) {
      setState(() {
        _quotesToShow = _quotesToShow + 10;
      });
    }
  }
}
