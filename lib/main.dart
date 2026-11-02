import 'package:demo/screens/pickers/pickers.dart';
import 'package:flutter/material.dart';

// import 'screens/s4/username.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Hive.initFlutter();

  // await Hive.openBox('userBox');
  // await Hive.openBox('user');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routerConfig: routers,
      home: DepartmentPicker(),
    );
  }
}
