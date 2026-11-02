import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import 'package:go_router/go_router.dart';

class Dashboardpage extends StatelessWidget {
  final Widget child;
  Dashboardpage({super.key, required this.child});

  final List tabs = [
    {"name": "Dashboard", "path": "/dash"},
    {"name": "Employee Management", "path": "/manage/cred"},
    {"name": "Employee Login", "path": "/login"},
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(title: Text("Welcome!")),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TabBar(
                onTap: (value) {
                  context.go(tabs[value]['path']);
                },
                tabs: List.generate(tabs.length, (index) {
                  return Tab(text: tabs[index]['name']);
                }),
              ),

              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class Dashtab extends StatelessWidget {
  const Dashtab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("data"));
  }
}

class EmployeManageTab extends StatelessWidget {
  final Widget child;
  EmployeManageTab({super.key, required this.child});

  final List innerTabs = [
    {"name": "Login Credentials", "path": "/manage/cred"},
    {"name": "Non-App Users", "path": "/manage/nonapp"},
    {"name": "Employee Activity", "path": "/manage/activity"},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              onTap: (value) {
                context.go(innerTabs[value]['path']);
              },
              tabs: List.generate(innerTabs.length, (index) {
                return Tab(text: innerTabs[index]['name']);
              }),
            ),

            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class EmployeLoginTab extends StatelessWidget {
  const EmployeLoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("data1"));
  }
}

class LoginCredTab extends StatelessWidget {
  const LoginCredTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("hiiiii"));
  }
}

class NonAppTab extends StatelessWidget {
  const NonAppTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("hellooo"));
  }
}

class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("yooooo"));
  }
}
