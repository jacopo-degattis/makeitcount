import 'package:flutter/material.dart';
import 'package:makeitcount/pages/home/components/expenses_pie_chart.dart';

class MonthlyReport extends StatefulWidget {
  const MonthlyReport({super.key});

  @override
  State<MonthlyReport> createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> {
  @override
  Widget build(BuildContext context) {
    final graphsSapcing = MediaQuery.of(context).size.width * 0.01;
    final cardHeight = MediaQuery.of(context).size.height * 0.23;
    final verticalCardPadding = MediaQuery.of(context).size.height * 0.02;
    final horizontalCardPadding = MediaQuery.of(context).size.width * 0.05;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 10),
          child: const Text("Monthly report",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalCardPadding,
                vertical: verticalCardPadding),
            child: SizedBox(
                width: double.infinity,
                height: cardHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: const ExpensesPieChart(
                              header: "Incomes",
                              progressColor: Color(0xFF1572A1),
                              percent: 0.74,
                              footer: "4,586.89"),
                        ),
                        SizedBox(
                            // width: 20.0,
                            width: graphsSapcing),
                        Container(
                          child: const ExpensesPieChart(
                            header: "Expenses",
                            progressColor: Color(0xFFC84361),
                            percent: 0.26,
                            footer: "300.99",
                          ),
                        ),
                      ],
                    ),
                    const Column(
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
