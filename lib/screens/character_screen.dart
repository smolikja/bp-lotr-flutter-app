import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';
import 'package:bp_flutter_app/models/characters_model.dart';
import 'package:bp_flutter_app/models/quotes_model.dart';
import 'package:bp_flutter_app/globals.dart';
import 'package:bp_flutter_app/widgets/list_divider.dart';

class CharacterScreen extends BaseStatefulWidget {
  final Character character;
  CharacterScreen({
    Key key,
    @required Function(Widget) fullscreenPush,
    @required this.character,
  }) : super(key: key, fullscreenPush: fullscreenPush);

  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
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
        title: widget.character.name,
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
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => ListDivider(indent: 16.0),
                  itemCount: _quoteData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(_quoteData[index].dialog),
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

  Future<List<Quote>> _getQuotes() async {
    return globalQuotes.docs.where((quote) => quote.character == widget.character.id).toList()..shuffle();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < _quotesToShow) {
      setState(() {
        _quotesToShow = _quotesToShow + 10;
      });
    }
  }
}
