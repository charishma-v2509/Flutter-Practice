import 'package:demo/screens/s6/gorouteexample.dart';
import 'package:go_router/go_router.dart';

final GoRouter routesss = GoRouter(
  initialLocation: '/home',

  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return DashboardShell(child: child);
      },

      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),

        GoRoute(path: '/users', builder: (context, state) => const UsersPage()),

        GoRoute(
          path: '/set',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: '/reports',
          builder: (context, state) => const ReportsPage(),
        ),
        GoRoute(
          path: '/time',
          builder: (context, state) => const TimingsPage(),
        ),
      ],
    ),
  ],
);
