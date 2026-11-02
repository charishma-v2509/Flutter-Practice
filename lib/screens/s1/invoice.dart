import 'package:demo/screens/s1/amount.dart';
import 'package:flutter/material.dart';

class Invoice extends StatelessWidget {
  const Invoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: const Color.fromARGB(188, 223, 228, 232),
        child: Column(
          crossAxisAlignment: .start,

          mainAxisAlignment: .start,
          children: [
            Row(
              children: [
                Text(
                  "Invoices",
                  style: TextStyle(fontSize: 40, fontWeight: .bold),
                ),
                SizedBox(width: 10),
                Text(
                  "15 Invoices",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: .none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    // mainAxisAlignment: .spaceBetween,
                    children: [
                      tabs("All"),
                      tabs("Draft"),
                      tabs("Sent"),
                      tabs("Partial"),
                      tabs("Paid"),
                      tabs("Overdue"),
                    ],
                  );
                },
                itemCount: 1,
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: Amount()),
          ],
        ),
      ),
    );
  }

  Widget tabs(String name) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(94, 182, 177, 177),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(name, style: TextStyle(color: Colors.grey)),
    );
  }
}
