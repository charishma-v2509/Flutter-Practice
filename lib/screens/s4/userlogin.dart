import 'package:demo/screens/s4/models/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final controller = Get.find<Login>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(controller.instituteData['institute_name'] ?? ""),
          SizedBox(height: 10),
          Text(controller.instituteData['institute_Alias'] ?? ""),
        ],
      ),
    );
  }
}
