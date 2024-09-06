import 'package:flutter/material.dart';
import 'package:makeitcount/state/models/movement.model.dart';
import 'package:makeitcount/pages/home/components/monthly_report.dart';
import 'package:makeitcount/pages/home/components/movements.dart';

// TODO: probably improve this name
// This could simply aggregate both 'Monthly report'
// and 'Movements' components
class ExpensesPreview extends StatefulWidget {
  final List<MovementModel> movements;

  const ExpensesPreview({super.key, required this.movements});

  @override
  State<ExpensesPreview> createState() => _ExpensesPreviewState();
}

class _ExpensesPreviewState extends State<ExpensesPreview> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MonthlyReport(),
          Movements(movements: widget.movements)
        ]);
  }
}
