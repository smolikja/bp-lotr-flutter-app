class QuotesModel {
  List<Quote> docs;

  QuotesModel({this.docs});

  QuotesModel.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = [];
      json['docs'].forEach((v) {
        docs.add(new Quote.fromJson(v));
      });
    }
  }
}

class Quote {
  String id;
  String dialog;
  String movie;
  String character;

  Quote({this.id, this.dialog, this.movie, this.character});

  Quote.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    dialog = json['dialog'];
    movie = json['movie'];
    character = json['character'];
  }
}
