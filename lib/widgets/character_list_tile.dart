import 'package:bp_flutter_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:bp_flutter_app/screens/base_stateful_widget.dart';
import 'package:bp_flutter_app/widgets/custom_appbar.dart';
import 'package:bp_flutter_app/models/characters_model.dart';
import 'package:bp_flutter_app/helpers/constants.dart';

class CharacterListTile extends BaseStatefulWidget {
  final String characterId;
  CharacterListTile({
    Key key,
    @required Function(Widget) fullscreenPush,
    @required this.characterId,
  }) : super(key: key, fullscreenPush: fullscreenPush);

  @override
  _CharacterListTileState createState() => _CharacterListTileState();
}

class _CharacterListTileState extends State<CharacterListTile> {
  Future<Character> _characterFuture;
  Character _characterData;

  @override
  void initState() {
    super.initState();
    _characterFuture = _getCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Character>(
      future: _characterFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        _characterData = snapshot.data;
        return ListTile(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             MovieScreen(fullscreenPush: widget.fullscreenPush, movie: _moviesData[index])));
          },
          title: Text(_characterData.name,
              style: TextStyle(color: kGreyLightColor, fontSize: 14.0, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.keyboard_arrow_right, color: kGreyLightColor, size: 24),
          dense: true,
        );
      },
    );
  }

  Future<Character> _getCharacter() async {
    return globalCharacters.docs.where((character) => character.id == widget.characterId).first;
  }
}
