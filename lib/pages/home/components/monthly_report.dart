import 'package:flutter/material.dart';

class MonthlyReport extends StatefulWidget {
  const MonthlyReport({super.key});

  @override
  State<MonthlyReport> createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 15, bottom: 10),
            child: Text("Monthly report",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        Card(
          child: Container(
              width: double.infinity, height: 150, child: Text("Hello World")),
        )
      ],
    );
  }
}
