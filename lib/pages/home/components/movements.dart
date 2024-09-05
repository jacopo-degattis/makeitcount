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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Movements",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(
                    "See all",
                    style: TextStyle(decoration: TextDecoration.underline),
                  )
                ],
              )),
          Container(
              child: Column(
            children: [
              SingleMovementCard(),
              SingleMovementCard(),
              SingleMovementCard(),
              SingleMovementCard(),
            ],
          ))
        ]);
  }
}
