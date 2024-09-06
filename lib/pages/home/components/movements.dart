import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makeitcount/pages/home/components/single_movment_card.dart';
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

    final movementsRepo = ref.watch(movementsRepositoryProvider);
    // I show only the three / four last movements
    // To see all others you need to use the See all page
    final movementsPreview =
        movementsRepo.getMovementsByMonth(widget.month, limit: 3);

    return Column(children: [
      Container(
          margin: EdgeInsets.only(top: margin, bottom: margin),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Movements",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "See all",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          )),
      Column(
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
    ]);
  }
}
