import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makeitcount/components/single_movment_card.dart';
import 'package:makeitcount/screens/see-all/see-all.dart';
import 'package:makeitcount/state/providers/movements/movements_repository.provider.dart';

class Movements extends ConsumerStatefulWidget {
  // final List<MovementModel> movements;
  final int month;

  const Movements({super.key, required this.month});

  @override
  ConsumerState<Movements> createState() => _MovementsState();
}

class _MovementsState extends ConsumerState<Movements> {
  @override
  Widget build(BuildContext context) {
    final margin = MediaQuery.of(context).size.height * 0.010;
    final noMovementsLabelSpacing = MediaQuery.of(context).size.height * 0.1;

    final movementsRepo = ref.watch(movementsRepositoryProvider);
    // I show only the three / four last movements
    // To see all others you need to use the See all page
    final movementsPreview =
        movementsRepo.getMovementsByMonth(widget.month, limit: 3);

    return Expanded(
      child: Column(children: [
        Container(
            margin: EdgeInsets.only(top: margin, bottom: margin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Movements",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // TODO: it's ok but maybe make it nicer to see
                SizedBox(
                  height: 30,
                  width: 90,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/see-all",
                          arguments: SeeAllArguments(widget.month));
                    },
                    child: const Text("See all"),
                  ),
                )
              ],
            )),
        movementsPreview.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: movementsPreview.map((movement) {
                  return SingleMovementCard(
                    title: movement.title,
                    category: movement.category,
                    price: movement.price,
                    image: movement.image,
                    type: movement.type,
                  );
                }).toList(),
              )
            : Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: noMovementsLabelSpacing),
                        child: Text("No movements for this month.")),
                  ],
                ),
              )
      ]),
    );
  }
}
