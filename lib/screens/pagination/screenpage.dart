import 'package:demo/screens/pagination/paginationapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Screenpage extends StatelessWidget {
  const Screenpage({super.key});

  @override
  Widget build(BuildContext context) {
    final Paginationapi controller = Get.put(Paginationapi());

    return Scaffold(
      appBar: AppBar(title: const Text("Pagination")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification value) {
                    if (value.metrics.pixels >= value.metrics.maxScrollExtent) {
                      controller.fetchPosts();
                      print("hasmore: ${controller.hasMore}");
                      print(controller.isLoading);
                    }

                    return false;
                  },
                  child: ListView.builder(
                    itemCount: controller.li.length,
                    itemBuilder: (context, index) {
                      final item = controller.li[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(item['id'].toString()),
                            const SizedBox(width: 20),
                            Expanded(child: Text(item['title'].toString())),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),

            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return SizedBox();
            }),

            // const SizedBox(height: 20),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         controller.prevPage();
            //       },
            //       child: const Text('<'),
            //     ),
            //     Obx(() => Text('Page ${controller.len.value}')),
            //     ElevatedButton(
            //       onPressed: () {
            //         controller.nextPage();
            //       },
            //       child: const Text('>'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
