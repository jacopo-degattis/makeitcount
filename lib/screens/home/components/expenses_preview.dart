import 'package:flutter/material.dart';
import 'package:makeitcount/screens/home/components/monthly_report.dart';
import 'package:makeitcount/screens/home/components/movements.dart';
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
    final marginSpacing = MediaQuery.of(context).size.width * 0.05;

    return !isDebouncing
        ? Container(
            margin: EdgeInsets.only(left: marginSpacing, right: marginSpacing),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MonthlyReport(month: widget.month),
                  Movements(month: widget.month)
                ]),
          )
        : const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [CircularProgressIndicator()],
          );
  }
}
