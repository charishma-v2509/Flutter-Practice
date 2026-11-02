import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  String message = 'No file selected';

  Future<void> pickFile() async {
    final PlatformFile? file = await FilePicker.pickFile();

    final v = await file?.length();

    setState(() {
      message = (file?.isBlank ?? true)
          ? "File selection cancelled"
          : 'Name: ${file?.name}\nSize: $v bytes';
    });
  }

  Future<void> pickDocuments() async {
    final List<PlatformFile> files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    setState(() {
      message = files.isEmpty
          ? 'File selection cancelled'
          : files.map((file) => file.name).join('\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('File Picker Example')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: pickFile,
                  child: const Text('Pick any file'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: pickDocuments,
                  child: const Text('Pick a document'),
                ),
                const SizedBox(height: 24),
                Text(message, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
