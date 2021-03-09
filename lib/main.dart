import 'package:flutter/material.dart';
import 'package:bp_flutter_app/globals.dart';
import 'package:bp_flutter_app/helpers/json_parse_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bp_flutter_app/services/app_localizations.dart';
import 'package:bp_flutter_app/widgets/phoenix.dart';
import 'package:bp_flutter_app/screens/guess_screen.dart';
import 'package:bp_flutter_app/screens/movies_list_screen.dart';
import 'package:bp_flutter_app/helpers/color_helper.dart';
import 'package:bp_flutter_app/helpers/constants.dart';

class _BottomBarItem {
  const _BottomBarItem(this.index, this.titleKey, this.icon, this.iconActive);

  final int index;
  final String titleKey;
  final Widget icon;
  final Widget iconActive;
}

List<_BottomBarItem> _bottomBarItems = <_BottomBarItem>[
  _BottomBarItem(0, 'bottombar_guess_quote', Icon(Icons.psychology_rounded), null),
  _BottomBarItem(1, 'appbar_quotes', Icon(Icons.format_quote_rounded), null)
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GlobalKey<NavigatorState>> _navigatorKeys =
      List<GlobalKey<NavigatorState>>.generate(_bottomBarItems.length, (index) => GlobalKey<NavigatorState>()).toList();
  int _currentIndex = 0;
  Future _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = Future.wait([_charactersFuture(), _moviesFuture(), _quotesFuture()]);
  }

  Future<String> _charactersFuture() async {
    return DefaultAssetBundle.of(context).loadString('assets/characters.json');
  }

  Future<String> _moviesFuture() async {
    return DefaultAssetBundle.of(context).loadString('assets/movies.json');
  }

  Future<String> _quotesFuture() async {
    return DefaultAssetBundle.of(context).loadString('assets/quotes.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: _fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          globalCharacters = JsonParseHelper().getCharacters(snapshot.data[0]);
          globalMovies = JsonParseHelper().getMovies(snapshot.data[1]);
          globalQuotes = JsonParseHelper().getQuotes(snapshot.data[2]);

          return WillPopScope(
            onWillPop: () async {
              final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentIndex].currentState.maybePop();
              return isFirstRouteInCurrentTab;
            },
            child: Scaffold(
              body: SafeArea(
                top: false,
                child: _getContent(),
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.black,
                unselectedItemColor: kGreyDarkColor,
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
            ),
          );
        },
      )),
    );
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
            screen = GuessScreen(fullscreenPush: _fullscreenPush);
            break;
          case 1:
            screen = MoviesListScreen(fullscreenPush: _fullscreenPush);
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
      title: 'LOTR Guess Character',
      theme: ThemeData(
          primarySwatch: createMaterialColor(kPrimaryColor),
          primaryTextTheme: TextTheme(headline6: TextStyle(color: createMaterialColor(kPrimaryColor))),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(bodyText1: TextStyle(), bodyText2: TextStyle()).apply(bodyColor: Colors.white)),
      home: MyHomePage(),
    ),
  ));
}
