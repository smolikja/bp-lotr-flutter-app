import 'package:bp_flutter_app/events/quote_list_event.dart';
import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';
import 'package:bp_flutter_app/models/characters_model.dart';
import 'package:bp_flutter_app/models/quotes_model.dart';
import 'package:bp_flutter_app/globals.dart';
import 'package:bp_flutter_app/widgets/list_divider.dart';
import 'package:bp_flutter_app/widgets/separator.dart';
import 'package:bp_flutter_app/widgets/character_info_widget.dart';
import 'package:flutter/services.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';
import 'package:bp_flutter_app/bloc/quote_list_bloc.dart';
import 'package:bp_flutter_app/widgets/load_failed_widget.dart';
import 'package:share/share.dart';

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
  final _bloc = QuoteListBloc();
  bool _showQuotesLoading;
  int _shownQuotes = 0;

  @override
  void initState() {
    super.initState();
    _quotesFuture = _getQuotes();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.character.name,
        fullscreenPush: widget.fullscreenPush,
      ),
      body: StreamBuilder<Object>(
          stream: _bloc.quoteList,
          initialData: 30,
          builder: (context, blocSnapshot) {
            _shownQuotes = blocSnapshot.data;
            return FutureBuilder<List<Quote>>(
              future: _quotesFuture,
              builder: (BuildContext context, AsyncSnapshot<List<Quote>> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return LoadFailedWidget(
                    function: () {
                      _quotesFuture = _getQuotes();
                      setState(() {});
                    },
                  );
                }
                _quoteData = snapshot.data.take(_shownQuotes).toList();
                _showQuotesLoading = (snapshot.data.length > _shownQuotes) ? true : false;

                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CharacterInfoWidget(
                        character: widget.character,
                        onShareTap: () {
                          Share.share(widget.character.wikiUrl);
                        },
                      ),
                      Separator(),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => ListDivider(indent: 16.0),
                        itemCount: _quoteData.length,
                        itemBuilder: (context, index) {
                          if (_quoteData[index].dialog.isNotEmpty) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: GestureDetector(
                                    child: Text(_quoteData[index].dialog),
                                    onLongPress: () {
                                      Clipboard.setData(new ClipboardData(text: _quoteData[index].dialog)).then((_) {
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Row(
                                            children: [
                                              Spacer(),
                                              Text(AppLocalizations.of(context).translate("quote_copy_text")),
                                              Spacer()
                                            ],
                                          ),
                                          duration: Duration(seconds: 1),
                                        ));
                                      });
                                    },
                                  )),
                            );
                          } else {
                            return null;
                          }
                        },
                      ),
                      if (_showQuotesLoading)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }

  Future<List<Quote>> _getQuotes() async {
    return globalQuotes.docs.where((quote) => quote.character == widget.character.id).toList()..shuffle();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _bloc.quoteListEventSink.add(IncrementEvent());
    }
  }
}
