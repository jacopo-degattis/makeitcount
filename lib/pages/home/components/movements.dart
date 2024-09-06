import 'package:flutter/material.dart';
import 'package:makeitcount/state/models/movement.model.dart';
import 'package:makeitcount/pages/home/components/single_movment_card.dart';

class Movements extends StatefulWidget {
  final List<MovementModel> movements;

  const Movements({super.key, required this.movements});

  @override
  State<Movements> createState() => _MovementsState();
}

class _MovementsState extends State<Movements> {
  @override
  Widget build(BuildContext context) {
    final margin = MediaQuery.of(context).size.height * 0.015;

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
        // children: [
        //   SingleMovementCard(
        //     title: "Conad",
        //     category: "Grocery",
        //     price: 34.39,
        //     image: "test",
        //   ),
        //   SingleMovementCard(
        //     title: "Conad",
        //     category: "Grocery",
        //     price: 34.39,
        //     image: "test",
        //   ),
        //   SingleMovementCard(
        //     title: "Conad",
        //     category: "Grocery",
        //     price: 34.39,
        //     image: "test",
        //   ),
        // ],
        children: widget.movements.map((movement) {
          return SingleMovementCard(
              title: movement.title,
              category: movement.category,
              price: movement.price,
              image: movement.image);
        }).toList(),
      )
    ]);
  }
}
