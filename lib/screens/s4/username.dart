import 'package:demo/screens/s4/models/login.dart';
import 'package:demo/screens/s4/userlogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final Login controller = Get.put(Login());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFFFEECAF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.person_outline_rounded,
                size: 42,
                color: Color(0xFF8A6D1D),
              ),
              const SizedBox(height: 10),
              const Text(
                "Welcome!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: controller.nameCtrl,
                decoration: InputDecoration(
                  hintText: "Enter your username",
                  prefixIcon: const Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onFieldSubmitted: (value) {
                  controller.validateUserName();
                },

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isUserCorrect.value) {
                  return passBox();
                }
                return SizedBox();
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.isUserCorrect.value) {
                      await controller.valdiatePassword();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ),
                      );
                    } else {
                      controller.validateUserName();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget passBox() {
    return TextFormField(
      obscureText: true,
      controller: controller.passCtrl,
      decoration: InputDecoration(
        hintText: "Enter your Password",
        prefixIcon: const Icon(Icons.lock_outline),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        }
        return null;
      },
    );
  }
}
