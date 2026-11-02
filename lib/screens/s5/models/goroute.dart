import 'package:demo/screens/s5/dashboardpage.dart';
import 'package:go_router/go_router.dart';

final GoRouter routers = GoRouter(
  initialLocation: '/dash',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Dashboardpage(child: child);
      },
      routes: [
        GoRoute(path: '/dash', builder: (context, state) => Dashtab()),
        ShellRoute(
          builder: (context, state, child) {
            return EmployeManageTab(child: child);
          },
          routes: [
            GoRoute(
              path: '/manage/cred',
              builder: (context, state) => LoginCredTab(),
            ),
            GoRoute(
              path: '/manage/nonapp',
              builder: (context, state) => NonAppTab(),
            ),
            GoRoute(
              path: '/manage/activity',
              builder: (context, state) => ActivityTab(),
            ),
          ],
        ),
        GoRoute(path: '/login', builder: (context, state) => EmployeLoginTab()),
      ],
    ),
  ],
);
