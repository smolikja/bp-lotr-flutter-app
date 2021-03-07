import 'package:flutter/material.dart';
import 'package:bp_flutter_app/models/characters_model.dart';
import 'package:bp_flutter_app/widgets/info_row.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';

class CharacterInfoWidget extends StatelessWidget {
  final Character character;

  CharacterInfoWidget({@required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (character.name != null && character.name.isNotEmpty)
                InfoRow(title: AppLocalizations.of(context).translate("character_title_name"), value: character.name),
              if (character.race != null && character.race.isNotEmpty)
                InfoRow(title: AppLocalizations.of(context).translate("character_title_race"), value: character.race),
              if (character.gender != null && character.gender.isNotEmpty)
                InfoRow(
                    title: AppLocalizations.of(context).translate("character_title_gender"), value: character.gender),
              if (character.height != null && character.height.isNotEmpty)
                InfoRow(
                    title: AppLocalizations.of(context).translate("character_title_height"), value: character.height),
              if (character.hair != null && character.hair.isNotEmpty)
                InfoRow(title: AppLocalizations.of(context).translate("character_title_hair"), value: character.hair),
              if (character.spouse != null && character.spouse.isNotEmpty)
                InfoRow(
                    title: AppLocalizations.of(context).translate("character_title_spouse"), value: character.spouse),
              if (character.birth != null && character.birth.isNotEmpty)
                InfoRow(title: AppLocalizations.of(context).translate("character_title_birth"), value: character.birth),
              if (character.realm != null && character.realm.isNotEmpty)
                InfoRow(title: AppLocalizations.of(context).translate("character_title_realm"), value: character.realm),
              if (character.death != null && character.death.isNotEmpty)
                InfoRow(title: AppLocalizations.of(context).translate("character_title_death"), value: character.death),
            ],
          ),
        ));
  }
}
