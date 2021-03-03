import 'package:flutter/material.dart';
import 'package:bp_flutter_app/models/characters_model.dart';
import 'package:bp_flutter_app/models/movies_model.dart';
import 'package:bp_flutter_app/models/quotes_model.dart';
import 'package:bp_flutter_app/helpers/json_parse_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  CharactersModel charactersData;
  MoviesModel moviesData;
  QuotesModel quotesData;

  Future<String> _charactersFuture() async {
    return DefaultAssetBundle.of(context).loadString('assets/characters.json');
  }

  Future<String> _moviesFuture() async {
    return DefaultAssetBundle.of(context).loadString('assets/movies.json');
  }

  Future<String> _quotesFuture() async {
    return DefaultAssetBundle.of(context).loadString('assets/quotes.json');
  }

  void _incrementCounter() {
    print(charactersData.docs.length);
    print(moviesData.docs.length);
    print(quotesData.docs.length);

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
        future: Future.wait([_charactersFuture(), _moviesFuture(), _quotesFuture()]),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            charactersData = JsonParseHelper().getCharacters(snapshot.data[0]);
            moviesData = JsonParseHelper().getMovies(snapshot.data[1]);
            quotesData = JsonParseHelper().getQuotes(snapshot.data[2]);
          }

          return !isEmpty(charactersData, moviesData, quotesData)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  bool isEmpty(CharactersModel characters, MoviesModel movies, QuotesModel quotes) {
    bool isEmpty = false;
    if (characters == null || movies == null || quotes == null) {
      isEmpty = true;
    }
    return isEmpty;
  }
}
