// pubspec.yaml:
//   dependencies:
//     flutter:
//       sdk: flutter
//     go_router: ^14.0.0   // use the latest version
//
// For clean web URLs (no '#'), also add flutter_web_plugins (sdk: flutter)
// and call usePathUrlStrategy() at the top of main().

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  // usePathUrlStrategy(); // uncomment for web (import 'package:flutter_web_plugins/url_strategy.dart')
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      // The shell: Scaffold + TabBar stay mounted; only the body changes.
      builder: (context, state, navigationShell) {
        return TabsShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const TabContent(title: 'Home'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const TabContent(title: 'Search'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const TabContent(title: 'Profile'),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GoRouter Tabs',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      routerConfig: _router,
    );
  }
}

class TabsShell extends StatefulWidget {
  const TabsShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<TabsShell> createState() => _TabsShellState();
}

class _TabsShellState extends State<TabsShell>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.navigationShell.currentIndex,
    );
  }

  @override
  void didUpdateWidget(covariant TabsShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Keep the TabBar in sync when the URL changes (back button, deep link).
    final index = widget.navigationShell.currentIndex;
    if (_tabController.index != index) {
      _tabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      // Tapping the active tab resets it to its first route.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs with GoRouter'),
        bottom: TabBar(
          controller: _tabController,
          onTap: _onTap,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.search), text: 'Search'),
            Tab(icon: Icon(Icons.person), text: 'Profile'),
          ],
        ),
      ),
      // The active branch is rendered here; the shell itself never rebuilds
      // as a new page, and each tab keeps its own state.
      body: widget.navigationShell,
    );
  }
}

class TabContent extends StatefulWidget {
  const TabContent({super.key, required this.title});

  final String title;

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  int _count = 0; // proves state is preserved when switching tabs

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text('Counter: $_count'),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => setState(() => _count++),
            child: const Text('Increment'),
          ),
        ],
      ),
    );
  }
}