import 'package:go_router/go_router.dart';
import 'package:tpnotemobile/ui/Jouer.dart';
import 'package:tpnotemobile/ui/Score.dart';


import '../app.dart';
import '../ui/Home.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'jouer',
          name: 'jouer',
          builder: (context, state) => const JouerPage(),
          routes: <RouteBase>[
            GoRoute(
              path: ':difficulte',
              name: 'difficulte',
              builder: (context, state) => const JouerPage(),
            ),
          ]
        ),
        GoRoute(
          path: 'scores',
          name: 'scores',
          builder: (context, state) => ScorePage(),
        ),
        GoRoute(
          path: 'regles',
          name: 'regles',
          builder: (context, state) => const MyHomePage(title: 'Règles'),
        ),
      ],
    ),
  ],
);