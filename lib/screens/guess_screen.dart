import 'package:bp_flutter_app/events/guess_screen_event.dart';
import 'package:bp_flutter_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';
import 'package:bp_flutter_app/models/characters_model.dart';
import 'package:bp_flutter_app/models/quotes_model.dart';
import 'package:bp_flutter_app/globals.dart';
import 'package:bp_flutter_app/screens/character_screen.dart';
import 'package:bp_flutter_app/widgets/load_failed_widget.dart';
import 'package:bp_flutter_app/widgets/separator.dart';
import 'package:bp_flutter_app/bloc/guess_screen_bloc.dart';
import "dart:math";
import 'package:flutter/services.dart';

class GuessScreen extends BaseStatefulWidget {
  GuessScreen({
    Key key,
    @required Function(Widget) fullscreenPush,
  }) : super(key: key, fullscreenPush: fullscreenPush);

  @override
  _GuessScreenState createState() => _GuessScreenState();
}

class _GuessScreenState extends State<GuessScreen> {
  final _bloc = GuessSrceenBloc();
  Future<Map<Quote, Character>> _contentFuture;
  Map<Quote, Character> _contentData;
  bool _covered;

  @override
  void initState() {
    super.initState();
    _contentFuture = _getContent();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context).translate('appbar_guess_quote'),
        fullscreenPush: widget.fullscreenPush,
      ),
      body: StreamBuilder<Object>(
          stream: _bloc.guessScreen,
          initialData: true,
          builder: (context, blocSnapshot) {
            _covered = blocSnapshot.data;
            return FutureBuilder<Map<Quote, Character>>(
              future: _contentFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<Map<Quote, Character>> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data == null) {
                  return LoadFailedWidget(
                    function: () {
                      _contentFuture = _getContent();
                      setState(() {});
                    },
                  );
                }
                _contentData = snapshot.data;
                return Container(
                    child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: GestureDetector(
                              onLongPress: () {
                                Clipboard.setData(new ClipboardData(
                                        text: _contentData.keys.first.dialog))
                                    .then((_) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(AppLocalizations.of(context)
                                        .translate("quote_copy_text")),
                                    duration: Duration(seconds: 1),
                                  ));
                                });
                              },
                              child: Text(
                                _contentData.keys.first.dialog,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_covered)
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 110,
                          color: kPrimaryColor,
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context)
                                .translate('guess_screen_uncover')
                                .toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        onTap: () {
                          _bloc.guessScreenEventSink.add(UncoverEvent());
                        },
                      ),
                    if (!_covered)
                      Column(
                        children: [
                          charListTile(_contentData.values.first),
                          GestureDetector(
                            child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('guess_screen_next')
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              _contentFuture = _getContent();
                              _bloc.guessScreenEventSink.add(CoverEvent());
                            },
                          )
                        ],
                      )
                  ],
                ));
              },
            );
          }),
    );
  }

  Column charListTile(Character character) {
    return Column(
      children: [
        Separator(customColor: kPrimaryColor),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharacterScreen(
                        fullscreenPush: widget.fullscreenPush,
                        character: character)));
          },
          title: Text(character.name,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold)),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: kPrimaryColor, size: 24),
          dense: true,
        ),
        Separator(customColor: kPrimaryColor)
      ],
    );
  }

  Future<Map<Quote, Character>> _getContent() async {
    final _random = new Random();
    Quote _randomQuote =
        globalQuotes.docs[_random.nextInt(globalQuotes.docs.length)];
    Character _character = globalCharacters.docs
        .where((character) => character.id == _randomQuote.character)
        .first;
    return {_randomQuote: _character};
  }
}
