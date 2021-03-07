import 'package:flutter/material.dart';
import 'package:bp_flutter_app/models/movies_model.dart';
import 'package:bp_flutter_app/widgets/info_row.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';

class MovieInfoWidget extends StatelessWidget {
  final Movie movie;

  MovieInfoWidget({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (movie.name != null && movie.name != "")
                InfoRow(title: AppLocalizations.of(context).translate("movie_title_name"), value: movie.name),
              if (movie.runtimeInMinutes != null && movie.runtimeInMinutes != "")
                InfoRow(
                    title: AppLocalizations.of(context).translate("movie_title_runtime"),
                    value: movie.runtimeInMinutes.toString()),
              if (movie.budgetInMillions != null && movie.budgetInMillions != "")
                InfoRow(
                    title: AppLocalizations.of(context).translate("movie_title_budget"),
                    value: movie.budgetInMillions.toString()),
              if (movie.boxOfficeRevenueInMillions != null && movie.boxOfficeRevenueInMillions != "")
                InfoRow(
                    title: AppLocalizations.of(context).translate("movie_title_box_revenue"),
                    value: movie.budgetInMillions.toString()),
              if (movie.academyAwardNominations != null && movie.academyAwardNominations != "")
                InfoRow(
                    title: AppLocalizations.of(context).translate("movie_title_nominations"),
                    value: movie.academyAwardNominations.toString()),
              if (movie.academyAwardWins != null && movie.academyAwardWins != "")
                InfoRow(
                    title: AppLocalizations.of(context).translate("movie_title_wins"),
                    value: movie.academyAwardWins.toString()),
              if (movie.rottenTomatesScore != null && movie.rottenTomatesScore != "")
                InfoRow(
                    title: AppLocalizations.of(context).translate("movie_title_rotten_score"),
                    value: movie.rottenTomatesScore.toString())
            ],
          ),
        ));
  }
}
