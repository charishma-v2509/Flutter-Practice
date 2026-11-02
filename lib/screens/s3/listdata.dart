import 'package:demo/screens/s3/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiTable extends StatelessWidget {
  ApiTable({super.key});

  final ApiService controller = Get.put(ApiService());

  //   @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Users")),

      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: controller.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // print(snapshot);
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  // print(snapshot);
                  return Text("Error");
                }
                // print(snapshot);
                return Container(
                  padding: const EdgeInsets.all(10),

                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      GetBuilder<ApiService>(
                        id: 'update',
                        builder: (_) {
                          return Obx(
                            () => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,

                              child: DataTable(
                                border: TableBorder.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),

                                columns: const [
                                  DataColumn(label: Text("Id")),
                                  DataColumn(label: Text("Name")),
                                  DataColumn(label: Text("Username")),
                                  DataColumn(label: Text("Email")),
                                  DataColumn(label: Text("Edit")),
                                  DataColumn(label: Text("Delete")),
                                ],

                                rows: List.generate(controller.data.length, (
                                  index,
                                ) {
                                  final user = controller.data[index];
                                  return DataRow(
                                    cells: [
                                      DataCell(Text("${index + 1}")),

                                      DataCell(Text(user.name)),

                                      DataCell(Text(user.username)),

                                      DataCell(Text(user.email)),
                                      DataCell(
                                        IconButton(
                                          onPressed: () =>
                                              openeditbox(context, user),
                                          icon: const Icon(Icons.edit),
                                        ),
                                      ),
                                      DataCell(
                                        IconButton(
                                          onPressed: () {
                                            controller.data.remove(user);
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
                // }
              },
            ),
          ],
        ),
      ),
    );
  }

  void openeditbox(BuildContext context, UserModel user) {
    final nameCtrl = TextEditingController(text: user.name);
    final userCtrl = TextEditingController(text: user.username);
    final emailCtrl = TextEditingController(text: user.email);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit user'),
          content: Column(
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: "Name"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: userCtrl,
                decoration: InputDecoration(labelText: "UserName"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: "Email"),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                    ),
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      user.name = nameCtrl.text;
                      user.username = userCtrl.text;
                      user.email = emailCtrl.text;
                      controller.update(['update']);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade300,
                    ),
                    child: Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
