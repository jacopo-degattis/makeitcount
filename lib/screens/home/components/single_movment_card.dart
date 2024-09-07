import 'package:flutter/material.dart';

class SingleMovementCard extends StatelessWidget {
  final String title;
  final String category;
  final double price; // TODO: it's price the best name ?
  final String image;
  final int type;

  const SingleMovementCard({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.image,
    required this.type,
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
              const Icon(
                Icons.local_grocery_store_outlined,
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
                  child: type == 0
                      ? const Icon(
                          Icons.arrow_outward,
                          color: Color(0xFFC84361),
                        )
                      : const Icon(
                          Icons.south_west,
                          color: Color(0xFF1572A1),
                        ))
            ],
          ),
          Text(
            "\$ $price",
            style: const TextStyle(color: Color(0xFFC84361)),
          )
        ],
      ),
    ));
  }
}
