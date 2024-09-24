import 'package:flutter/material.dart';

class SingleMovementCard extends StatelessWidget {
  final String title;
  final String category;
  final double price; // TODO: it's price the best name ?
  final int imageCodePoint;
  final bool income;

  const SingleMovementCard({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.imageCodePoint,
    required this.income,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                IconData(imageCodePoint, fontFamily: 'MaterialIcons'),
                size: 30.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      category,
                      style: const TextStyle(fontWeight: FontWeight.w100),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 7.0),
                child: income
                    ? const Icon(
                        Icons.south_west,
                        color: Color(0xFF1572A1),
                      )
                    : const Icon(
                        Icons.arrow_outward,
                        color: Color(0xFFC84361),
                      ),
              )
            ],
          ),
          Text(
            "\$ $price",
            style: TextStyle(
                color:
                    income ? const Color(0xFF1572A1) : const Color(0xFFC84361)),
          )
        ],
      ),
    ));
  }
}
