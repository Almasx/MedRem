import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lark/widgets/widgets.dart';

import '../models/pill.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.pill,
    required this.index,
  }) : super(key: key);
  final Pill pill;
  final int index;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => {Navigator.pop(context)},
              child: const Icon(Iconsax.arrow_left_2)),
        ),
        title: const Text(
          'Details',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: Stack(children: [
        const GridBackground(),
        Positioned(
            left: 15,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Text(
                    widget.pill.description,
                    style: TextStyle(
                        height: 0.95,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.4),
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  ),
                ),
              ],
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.pill.title}, 250mg',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
              ),
              Text(
                '${widget.pill.dosage} pill, once per day',
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.33),
                    fontSize: 20),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Hero(
                  tag: 'image' + widget.index.toString(),
                  child: Image.asset(
                    "assets/images/Pill.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                widget.pill.time.format(context),
                style: const TextStyle(
                  fontSize: 32,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
