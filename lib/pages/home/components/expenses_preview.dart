import 'package:flutter/material.dart';
import 'package:makeitcount/pages/home/components/monthly_report.dart';
import 'package:makeitcount/pages/home/components/movements.dart';
import 'package:makeitcount/util.dart';

// TODO: probably improve this name
// This could simply aggregate both 'Monthly report'
// and 'Movements' components
class ExpensesPreview extends StatefulWidget {
  // final List<MovementModel> movements;
  final int month;

  const ExpensesPreview({super.key, required this.month});

  @override
  State<ExpensesPreview> createState() => _ExpensesPreviewState();
}

class _ExpensesPreviewState extends State<ExpensesPreview> {
  bool isDebouncing = true;
  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _debouncer.run(() {
      setState(() {
        isDebouncing = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _debouncer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return !isDebouncing
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const MonthlyReport(),
                Movements(
                  month: widget.month,
                )
              ])
        : const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [CircularProgressIndicator()],
          );
  }
}
