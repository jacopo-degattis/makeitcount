import 'package:flutter/material.dart';
import 'package:makeitcount/pages/home/components/monthly_report.dart';
import 'package:makeitcount/pages/home/components/movements.dart';

// TODO: probably improve this name
// This could simply aggregate both 'Monthly report'
// and 'Movements' components
class ExpensesPreview extends StatefulWidget {
  const ExpensesPreview({super.key});

  @override
  State<ExpensesPreview> createState() => _ExpensesPreviewState();
}

class _ExpensesPreviewState extends State<ExpensesPreview> {
  @override
  Widget build(BuildContext context) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [MonthlyReport(), Movements()]);
  }
}
