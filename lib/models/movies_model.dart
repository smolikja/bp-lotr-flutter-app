class MoviesModel {
  List<Docs> docs;

  MoviesModel({this.docs});

  MoviesModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  dynamic runtimeInMinutes;
  dynamic budgetInMillions;
  dynamic boxOfficeRevenueInMillions;
  dynamic academyAwardNominations;
  dynamic academyAwardWins;
  dynamic rottenTomatesScore;

  Docs(
      {this.id,
      this.name,
      this.runtimeInMinutes,
      this.budgetInMillions,
      this.boxOfficeRevenueInMillions,
      this.academyAwardNominations,
      this.academyAwardWins,
      this.rottenTomatesScore});

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    runtimeInMinutes = json['runtimeInMinutes'];
    budgetInMillions = json['budgetInMillions'];
    boxOfficeRevenueInMillions = json['boxOfficeRevenueInMillions'];
    academyAwardNominations = json['academyAwardNominations'];
    academyAwardWins = json['academyAwardWins'];
    rottenTomatesScore = json['rottenTomatesScore'];
  }
}
