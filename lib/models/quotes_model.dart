class QuotesModel {
  List<Docs> docs;

  QuotesModel({this.docs});

  QuotesModel.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = [];
      json['docs'].forEach((v) {
        docs.add(new Docs.fromJson(v));
      });
    }
  }
}

class Docs {
  String id;
  String dialog;
  String movie;
  String character;

  Docs({this.id, this.dialog, this.movie, this.character});

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    dialog = json['dialog'];
    movie = json['movie'];
    character = json['character'];
  }
}
