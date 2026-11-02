// import 'package:demo/screens/s2/formres.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formState = GlobalKey<FormState>();
  final nameControl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Forms")),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formState,
          child: Column(
            children: [
              TextFormField(
                controller: nameControl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: "Enter your Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: "Enter your Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "email is required";
                  } else if (!value.endsWith("@gmail.com")) {
                    return "invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: phoneCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: "Enter your Phone number",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone Number is required";
                  } else if (value.length != 10) {
                    return "invalid Phone Number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  UserData obj = UserData(
                    email: emailCtrl.text,
                    name: nameControl.text,
                  );

                  obj.name = "SIva";

                  obj.validate();

                  debugPrint(obj.name);

                  // TypeClass oasd = TypeClass();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserData {
  String name;
  final String email;
  final String phoneNo;
  UserData({required this.name, required this.email, this.phoneNo = ""});

  void validate() {
    name = "Sasd";
  }
}