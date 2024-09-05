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
    return CircularPercentIndicator(
      radius: 45.0,
      animation: true,
      lineWidth: 8.0,
      percent: percent,
      startAngle: 0.0,
      progressColor: progressColor,
      circularStrokeCap: CircularStrokeCap.round,
      header:
          Container(margin: EdgeInsets.only(bottom: 15.0), child: Text(header)),
      center: Text("${percent * 100}%"),
      footer: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Text(
          "\$ ${footer}",
        ),
      ),
      // widgetIndicator: Center(
      //   child: Container(
      //     height: 20,
      //     width: 20,
      //     decoration: BoxDecoration(
      //       color: Colors.yellow,
      //       borderRadius: BorderRadius.circular(50),
      //     ),
      //     padding: const EdgeInsets.all(5),
      //     child: Container(
      //       decoration: BoxDecoration(
      //         color: Colors.yellow,
      //         borderRadius: BorderRadius.circular(50),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
