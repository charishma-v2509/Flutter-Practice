import 'package:demo/screens/s3/models/apidemo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Demoapi extends StatelessWidget {
  Demoapi({super.key});

  final Apidemo controller = Get.put(Apidemo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Users")),

      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Sources",
                    style: TextStyle(fontSize: 50, fontWeight: .bold),
                  ),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.upload_file)),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    onPressed: () {
                      openBox(context);
                    },
                    child: Text(
                      "+ Add Data",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              GetBuilder<Apidemo>(
                id: "chaloo",
                builder: (context) {
                  return FutureBuilder(
                    future: controller.getUser(),

                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // if (snapshot.hasError) {
                      //   return const Center(child: Text("Error"));
                      // }

                      return Container(
                        padding: const EdgeInsets.all(10),

                        child: Column(
                          children: [
                            const SizedBox(height: 20),

                            GetBuilder<Apidemo>(
                              id: "hello",
                              builder: (apidemo) {
                                final activeUsers = controller.abc
                                    .where(
                                      (element) => element["status"] == true,
                                    )
                                    .toList();
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    border: TableBorder.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    columns: const [
                                      DataColumn(label: Text("Id")),
                                      DataColumn(label: Text("sourceID")),
                                      DataColumn(label: Text("source")),
                                      DataColumn(label: Text("description")),
                                      DataColumn(label: Text("Edit")),
                                      DataColumn(label: Text("Delete")),
                                    ],
                                    rows: List.generate(activeUsers.length, (
                                      index,
                                    ) {
                                      final user = activeUsers[index];

                                      return DataRow(
                                        cells: [
                                          DataCell(Text("${index + 1}")),
                                          DataCell(
                                            Text(user["sourceID"].toString()),
                                          ),
                                          DataCell(
                                            Text(user["source"].toString()),
                                          ),
                                          DataCell(
                                            Text(
                                              user["description"].toString(),
                                            ),
                                          ),
                                          DataCell(
                                            IconButton(
                                              onPressed: () {
                                                openBox(
                                                  context,
                                                  isEdit: true,
                                                  index: index,
                                                );
                                              },
                                              icon: const Icon(Icons.edit),
                                            ),
                                          ),
                                          DataCell(
                                            IconButton(
                                              onPressed: () {
                                                alertingbox(context, index);
                                              },
                                              icon: const Icon(Icons.delete),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void alertingbox(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Are you sure you want to delete?"),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  controller.inactiveSource(index);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 251, 120, 72),
                ),

                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  void openBox(BuildContext context, {bool isEdit = false, int? index}) {
    final user = isEdit ? controller.abc[index!] : <String, dynamic>{};
    String source = isEdit ? user['source'] : " ";
    String des = isEdit ? user['description'] : " ";
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? "Edit User" : "Add User"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: source,
                // : sourceCtrl,
                decoration: const InputDecoration(labelText: "Source"),
                onChanged: (value) {
                  source = value;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                initialValue: des,

                decoration: const InputDecoration(labelText: "Description"),
                onChanged: (value) {
                  des = value;
                },
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                    ),

                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),

                  // SAVE
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      isEdit
                          ? controller.updateSource(index!, source, des)
                          : controller.addSource(source, des);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade300,
                    ),

                    child: const Text("Save"),
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
