import 'dart:async';
import 'package:bp_flutter_app/events/quote_list_event.dart';

class QuoteListBloc {
  int _quotesToShow = 10;

  final _quoteListBlocStateController = StreamController<int>();
  StreamSink<int> get _inQuoteList => _quoteListBlocStateController.sink;

  Stream<int> get quoteList => _quoteListBlocStateController.stream;

  final _quoteListEventController = StreamController<QuoteListEvent>();

  Sink<QuoteListEvent> get quoteListEventSink => _quoteListEventController.sink;

  QuoteListBloc() {
    _quoteListEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(QuoteListEvent _) {
    _quotesToShow = _quotesToShow + 30;
    _inQuoteList.add(_quotesToShow);
  }

  void dispose() {
    _quoteListBlocStateController.close();
    _quoteListEventController.close();
  }
}
