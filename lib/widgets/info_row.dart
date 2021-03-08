import 'package:flutter/material.dart';
import 'package:bp_flutter_app/helpers/constants.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  InfoRow({@required this.title, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                value,
                style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
