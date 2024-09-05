import 'package:flutter/material.dart';
import 'package:makeitcount/pages/home/components/single_movment_card.dart';

class Movements extends StatefulWidget {
  const Movements({super.key});

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
      const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleMovementCard(
            title: "Conad",
            category: "Grocery",
            price: 34.39,
            image: "test",
          ),
          SingleMovementCard(
            title: "Conad",
            category: "Grocery",
            price: 34.39,
            image: "test",
          ),
          SingleMovementCard(
            title: "Conad",
            category: "Grocery",
            price: 34.39,
            image: "test",
          ),
        ],
      )
    ]);
  }
}
