import 'package:flutter/material.dart';

class Formres extends StatelessWidget {
  final String name;
  final String email;
  final String number;
  const Formres({super.key, required this.name, required this.email, required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: .center,
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(100), 
        ),
        child: Column(
          children: [
            Text(name),
            SizedBox(height: 20),
            Text(email),
            SizedBox(height: 20),
            Text(number),
          ],
        ),
      ),
    );
  }
}