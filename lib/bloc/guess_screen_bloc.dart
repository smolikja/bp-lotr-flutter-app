import 'dart:async';
import 'package:bp_flutter_app/events/guess_screen_event.dart';

class GuessSrceenBloc {
  bool _isCovered;

  final _guessSrceenStateController = StreamController<bool>();
  StreamSink<bool> get _inGuessScreen => _guessSrceenStateController.sink;

  Stream<bool> get guessScreen => _guessSrceenStateController.stream;

  final _guessSrceenEventController = StreamController<GuessScreenEvent>();

  Sink<GuessScreenEvent> get guessScreenEventSink => _guessSrceenEventController.sink;

  GuessSrceenBloc() {
    _guessSrceenEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(GuessScreenEvent event) {
    _isCovered = (event is CoverEvent) ? true : false;
    _inGuessScreen.add(_isCovered);
  }

  void dispose() {
    _guessSrceenStateController.close();
    _guessSrceenEventController.close();
  }
}
