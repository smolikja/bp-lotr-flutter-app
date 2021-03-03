import 'package:flutter/material.dart';
import 'package:bp_flutter_app/models/characters_model.dart';
import 'package:bp_flutter_app/models/movies_model.dart';
import 'package:bp_flutter_app/models/quotes_model.dart';
import 'package:bp_flutter_app/helpers/json_parse_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';
import 'package:bp_flutter_app/widgets/phoenix.dart';

class _BottomBarItem {
  const _BottomBarItem(this.index, this.titleKey, this.icon, this.iconActive);

  final int index;
  final String titleKey;
  final Widget icon;
  final Widget iconActive;
}

List<_BottomBarItem> _bottomBarItems = <_BottomBarItem>[
  _BottomBarItem(0, 'appbar_guess_quote', Icon(Icons.article_outlined), null),
  _BottomBarItem(1, 'appbar_characters', Icon(Icons.date_range_outlined), null)
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GlobalKey<NavigatorState>> _navigatorKeys =
      List<GlobalKey<NavigatorState>>.generate(_bottomBarItems.length, (index) => GlobalKey<NavigatorState>()).toList();
  int _counter = 0;
  int _currentIndex = 0;

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
        title: Text('LOTR Guess the Quote'),
      ),
      body: Center(
          child: FutureBuilder(
        future: Future.wait([_charactersFuture(), _moviesFuture(), _quotesFuture()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            charactersData = JsonParseHelper().getCharacters(snapshot.data[0]);
            moviesData = JsonParseHelper().getMovies(snapshot.data[1]);
            quotesData = JsonParseHelper().getQuotes(snapshot.data[2]);
          }

          return Scaffold(
            body: SafeArea(
              top: false,
              child: _getContent(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              onTap: (int index) {
                _navigatorKeys[_currentIndex].currentState.popUntil((route) => route.isFirst);
                setState(() {
                  _currentIndex = index;
                });
              },
              items: _bottomBarItems.map((_BottomBarItem item) {
                return BottomNavigationBarItem(
                  icon: item.icon,
                  activeIcon: item.iconActive,
                  label: AppLocalizations.of(context).translate(item.titleKey),
                );
              }).toList(),
            ),
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

  Widget _getContent() {
    var routeBuilders = _routeBuilders(_currentIndex);
    return Navigator(
      key: _navigatorKeys[_currentIndex],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(int index) {
    return {
      '/': (context) {
        Widget screen;
        switch (index) {
          case 0:
            screen = Column(
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
            );
            break;
          case 1:
            screen = Column(
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
            );
            break;
        }
        return screen;
      },
    };
  }

  void _fullscreenPush(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}

void main() {
  runApp(Phoenix(
    child: MaterialApp(
      supportedLocales: [Locale('en', 'US')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'LOTR Guess Quote',
      theme: ThemeData(
        // primarySwatch: createMaterialColor(kPrimaryColor),
        // primaryTextTheme: TextTheme(headline6: TextStyle(color: createMaterialColor(kPrimaryColor))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    ),
  ));
}
