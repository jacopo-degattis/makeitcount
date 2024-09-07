import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makeitcount/components/single_movment_card.dart';
import 'package:makeitcount/state/providers/movements/movements_repository.provider.dart';

class SeeAllArguments {
  final int month;

  SeeAllArguments(this.month);
}

class SeeAll extends ConsumerStatefulWidget {
  const SeeAll({super.key});

  @override
  ConsumerState<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends ConsumerState<SeeAll> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SeeAllArguments;

    final movementsRepo = ref.watch(movementsRepositoryProvider);
    final allMovements = movementsRepo.getMovementsByMonth(args.month);

    return Scaffold(
        appBar: AppBar(
          // TODO: maybe user should be able to also switch month from this screen ?
          // TODO: should I specify which month you're watching the movements of ?
          title: const Text("All movements"),
          notificationPredicate: (_) => false,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0.0,
          forceMaterialTransparency: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: allMovements.map((movement) {
                return SingleMovementCard(
                  title: movement.title,
                  category: movement.category,
                  price: movement.price,
                  image: movement.image,
                  type: movement.type,
                );
              }).toList(),
            ),
          ),
        ));
  }
}
