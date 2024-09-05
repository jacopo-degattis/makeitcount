import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExpensesPieChart extends StatelessWidget {
  final Color progressColor;
  final double percent;
  final String header;
  final String footer;

  const ExpensesPieChart({
    super.key,
    required this.header,
    required this.progressColor,
    required this.percent,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width * 0.15;
    final spacing = MediaQuery.of(context).size.height * 0.02;

    return CircularPercentIndicator(
      radius: radius,
      animation: true,
      lineWidth: 8.0,
      percent: percent,
      startAngle: 0.0,
      progressColor: progressColor,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: progressColor.withOpacity(0.4),
      // header: Container(
      //   margin: EdgeInsets.only(bottom: spacing),
      //   child: Text(header),
      // ),
      center: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(header),
        Text("${percent * 100}%"),
      ]),
      footer: Container(
        margin: EdgeInsets.only(top: spacing),
        child: Text(
          "\$ $footer",
        ),
      ),
    );
  }
}
