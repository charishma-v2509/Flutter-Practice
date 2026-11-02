import 'package:flutter/material.dart';

List<Map<String, dynamic>> transactions = [
  {
    "company": "Beta Solutions",
    "service": "Mobile App Development",
    "amount": "\$1,800",
    "invoice": "INV-110450",
    "status": "Paid",
    "date": "Oct 20, 2026",
  },
  {
    "company": "Epsilon Enterprises",
    "service": "Graphic Design",
    "amount": "\$2,000",
    "invoice": "INV-1078",
    "status": "Partial",
    "date": "Sep 15, 2026",
  },
  {
    "company": "Gamma Innovations",
    "service": "UI/UX Design",
    "amount": "\$3,200",
    "invoice": "INV-110520",
    "status": "Sent",
    "date": "Sep 1, 2026",
  },
  {
    "company": "Acme Studio",
    "service": "Website Design & Development",
    "amount": "\$2,400",
    "invoice": "INV-110300",
    "status": "Overdue",
    "date": "Aug 16, 2026",
  },
  {
    "company": "Acme Studio",
    "service": "Website Design & Development",
    "amount": "\$2,400",
    "invoice": "INV-110300",
    "status": "Overdue",
    "date": "Aug 16, 2026",
  },
  {
    "company": "Acme Studio",
    "service": "Website Design & Development",
    "amount": "\$2,400",
    "invoice": "INV-110300",
    "status": "Overdue",
    "date": "Aug 16, 2026",
  },
  {
    "company": "Acme Studio",
    "service": "Website Design & Development",
    "amount": "\$2,400",
    "invoice": "INV-110300",
    "status": "Overdue",
    "date": "Aug 16, 2026",
  },
  {
    "company": "Acme Studio",
    "service": "Website Design & Development",
    "amount": "\$2,400",
    "invoice": "INV-110300",
    "status": "Overdue",
    "date": "Aug 16, 2026",
  },
];

    List<Color> li = [Colors.green, Colors.orange, Colors.red];


class Amount extends StatelessWidget {
  const Amount({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final item = transactions[index];
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.business),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["company"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 4),

                      Text(
                        item["service"],
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    item["amount"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),

              Row(
                children: [
                  Icon(Icons.receipt_outlined, size: 14, color: Colors.grey),

                  SizedBox(width: 5),

                  Text(
                    item["invoice"],
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),

                  SizedBox(width: 8),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),

                    decoration: BoxDecoration(
                      color: statuscode(index),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Text(
                      item["status"],
                      style: TextStyle(fontSize: 10, color:
                      statuscode(index)
                       ),
                    ),
                  ),

                  Spacer(),

                  Text(
                    item["date"],
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  Color statuscode(int index) {
     if (index % 3 == 0) {
    return Colors.green;
  } else if (index % 3 == 1) {
    return Colors.orange;
  } else if (index % 3 == 2) {
    return Colors.blue;
  } else {
    return Colors.grey;
  }
  }
}
