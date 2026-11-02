import 'package:flutter/material.dart';

class Tablepage extends StatelessWidget {
  Tablepage({super.key});

  final List<Map<String, dynamic>> users = List.generate(
    90,
    (index) => {
      'id': index + 1,
      'name': 'User ${index + 1}',
      'email': 'user${index + 1}@gmail.com',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Table')),
      body: Column(
        children: [
          Divider(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: const Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          // Scrollable rows
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(child: Text(user['id'].toString())),
                          ),
                          Expanded(child: Center(child: Text(user['name']))),
                          Expanded(child: Center(child: Text(user['email']))),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
