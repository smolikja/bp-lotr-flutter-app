class MoviesModel {
  List<Movie> docs;

  MoviesModel({this.docs});

  MoviesModel.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = [];
      json['docs'].forEach((v) {
        docs.add(new Movie.fromJson(v));
      });
    }
  }
}

class Movie {
  String id;
  String name;
  dynamic runtimeInMinutes;
  dynamic budgetInMillions;
  dynamic boxOfficeRevenueInMillions;
  dynamic academyAwardNominations;
  dynamic academyAwardWins;
  dynamic rottenTomatesScore;

  Movie(
      {this.id,
      this.name,
      this.runtimeInMinutes,
      this.budgetInMillions,
      this.boxOfficeRevenueInMillions,
      this.academyAwardNominations,
      this.academyAwardWins,
      this.rottenTomatesScore});

  Movie.fromJson(Map<String, dynamic> json) {
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
