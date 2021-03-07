import 'package:bp_flutter_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';
import 'package:bp_flutter_app/models/movies_model.dart';
import 'package:bp_flutter_app/models/quotes_model.dart';
import 'package:bp_flutter_app/widgets/list_divider.dart';

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
  int _quotesToShow = 20;

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
            _quoteData = snapshot.data..shuffle();
            List<Quote> _quotesList = _quoteData.take(_quotesToShow).toList();

            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => ListDivider(indent: 16.0),
                    itemCount: _quotesList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(_quotesList[index].dialog),
                            //   ListTile(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 MovieScreen(fullscreenPush: widget.fullscreenPush, movie: _moviesData[index])));
                            //   },
                            //   title: Text(_moviesData[index].name,
                            //       style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold)),
                            //   // leading: items[index].icon,
                            //   trailing: Icon(Icons.keyboard_arrow_right, color: kGreyLightColor, size: 24),
                            //   dense: true,
                            // )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }

  Future<List<Quote>> _getQuotes() async {
    return globalQuotes.docs.where((element) => element.movie == widget.movie.id).toList();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < _quotesToShow) {
      setState(() {
        _quotesToShow = _quotesToShow + 20;
      });
    }
  }
}
