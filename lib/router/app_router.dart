import 'package:go_router/go_router.dart';

import '../app.dart';
import '../ui/Home.dart';

final router = GoRouter(
  initialLocation: '/',
  routes:<RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/scores',
      name: 'scores',
      builder: (context, state) => const MyHomePage(title: 'Score'),
    ),
    GoRoute(
      path: '/regles',
      name: 'regles',
      builder: (context, state) => const MyHomePage(title: 'Regles'),
    ),
    GoRoute(
      path: '/jouer',
      name: 'jouer',
      builder: (context, state) => const MyHomePage(title: 'Jouer'),
    ),
  ],
);
