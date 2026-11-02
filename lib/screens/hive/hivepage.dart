import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Hivepage extends StatefulWidget {
  const Hivepage({super.key});

  @override
  State<Hivepage> createState() => _HomePageState();
}

class _HomePageState extends State<Hivepage> {
  final box = Hive.box('userBox');
  final nameController = TextEditingController();

  String savedName = '';

  @override
  void initState() {
    super.initState();
    savedName = box.get('name', defaultValue: '').toString();
  }

  void saveName() async {
    final name = nameController.text.trim();

    if (name.isEmpty) return;
    box.put('name', name);

    setState(() {
      savedName = name;
    });

    nameController.clear();
  }

  void readName() {
    setState(() {
      savedName = box.get('name', defaultValue: 'No data found').toString();
    });
  }

  void updateName() {
    if (!box.containsKey('name')) return;

    box.put('name', 'Updated Name');

    readName();
  }

  void deleteName() {
    box.delete('name');

    setState(() {
      savedName = 'No data found';
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive Database Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("data"),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(onPressed: saveName, child: const Text('Save')),
            ElevatedButton(onPressed: readName, child: const Text('Read')),
            ElevatedButton(onPressed: updateName, child: const Text('Update')),
            ElevatedButton(onPressed: deleteName, child: const Text('Delete')),
            const SizedBox(height: 24),

            Text(
              'Saved value: $savedName',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
