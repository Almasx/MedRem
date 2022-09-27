import 'package:flutter/material.dart';
import 'package:lark/widgets/widgets.dart';

import '../../config/themes/theme.dart';

class ClockCard extends StatelessWidget {
  const ClockCard(
      {Key? key,
      required this.league,
      required this.price,
      required this.payRate,
      required this.durability,
      required this.onTap})
      : super(key: key);
  final String league;
  final double price;
  final double payRate;
  final int durability;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color leagueColor = leagues[league]!;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              width: (MediaQuery.of(context).size.width - 40) / 2,
              decoration: BoxDecoration(
                  border: Border.all(color: leagueColor, width: 2),
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.surface),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Text(
                        "${price.toString()} SOL",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      ButtonWidget(
                          text: const Text('Buy',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          onPressed: () {})
                    ]),
                  ])),
          Positioned(
              top: 0,
              child: Container(
                child: Text('${league[0].toUpperCase()}${league.substring(1)}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                decoration: BoxDecoration(
                    color: leagueColor,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              ))
        ],
      ),
    );
  }
}
