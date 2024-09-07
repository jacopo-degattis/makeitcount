import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makeitcount/screens/home/components/expenses_pie_chart.dart';
import 'package:makeitcount/state/providers/movements/movements_repository.provider.dart';

class MonthlyReport extends ConsumerStatefulWidget {
  final int month;

  const MonthlyReport({super.key, required this.month});

  @override
  ConsumerState<MonthlyReport> createState() => _MonthlyReportState();
}

class _MonthlyReportState extends ConsumerState<MonthlyReport> {
  @override
  Widget build(BuildContext context) {
    final movementsRepo = ref.watch(movementsRepositoryProvider);
    final graphPercentages =
        movementsRepo.getMovementsPercentages(widget.month);

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
                          child: ExpensesPieChart(
                              header: "Incomes",
                              progressColor: Color(0xFF1572A1),
                              percent: graphPercentages["incomes"]
                                          ["percentage"]!
                                      .toDouble() /
                                  100,
                              footer: graphPercentages["incomes"]["amount"]
                                  .toString()),
                        ),
                        SizedBox(
                            // width: 20.0,
                            width: graphsSapcing),
                        Container(
                          child: ExpensesPieChart(
                            header: "Expenses",
                            progressColor: Color(0xFFC84361),
                            percent: graphPercentages["outcomes"]["percentage"]!
                                    .toDouble() /
                                100,
                            footer: graphPercentages["outcomes"]["amount"]
                                .toString(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("\$ ${graphPercentages['total']}")
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
