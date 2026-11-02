import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardShell extends StatelessWidget {
  final Widget child;
  DashboardShell({super.key, required this.child});

  final List<Map<String, dynamic>> li = [
    {'name': 'Home', 'icon': Icons.home, 'route': '/home'},
    {'name': 'Users', 'icon': Icons.people, 'route': '/users'},
    {'name': 'Reports', 'icon': Icons.bar_chart, 'route': '/reports'},
    {'name': 'Timings', 'icon': Icons.access_time, 'route': '/time'},
    {'name': 'Settings', 'icon': Icons.settings, 'route': '/set'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 150,
            child: ListView.builder(
              itemCount: li.length,
              itemBuilder: (context, index) {
                final item = li[index];
                return InkWell(
                  onTap: () {
                    context.go(item['route']);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(width: 2, color: Colors.grey.shade100),
                    ),
                    child: Column(
                      children: [
                        Icon(item['icon']),
                        SizedBox(height: 5),
                        Text(item['name']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(child: child),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("homieee"));
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("usersss"));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("sesttings"));
  }
}

class TimingsPage extends StatelessWidget {
  const TimingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Timings"));
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.amber),
      child: Center(child: Text("reports")),
    );
  }
}
