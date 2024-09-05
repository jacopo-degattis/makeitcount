import 'package:flutter/material.dart';
import 'package:makeitcount/pages/home/components/pie_chart.dart';

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
        const Card(
          child: Padding(
            padding: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
            child: SizedBox(
                width: double.infinity,
                height: 180,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ExpensesPieChart(
                            header: "Incomes",
                            progressColor: Color(0xFF1572A1),
                            percent: 0.74,
                            footer: "4,586.89"),
                        SizedBox(
                          width: 20.0,
                        ),
                        ExpensesPieChart(
                          header: "Expenses",
                          progressColor: Color(0xFFC84361),
                          percent: 0.26,
                          footer: "300.99",
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("\$ 4,285.90")
                      ],
                    )
                  ],
                )),
          ),
        )
      ],
    );
  }
}
