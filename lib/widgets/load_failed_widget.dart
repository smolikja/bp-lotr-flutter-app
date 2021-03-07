import 'package:flutter/material.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';

class LoadFailedWidget extends StatelessWidget {
  final Function function;

  LoadFailedWidget({@required this.function});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context).translate("failed_load_title"),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: function,
                child: Text(AppLocalizations.of(context).translate("failed_load_refresh")),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
