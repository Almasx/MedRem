import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../models/date.dart';
import '../../models/pill.dart';
import '../../router/routes.dart';
import '../../widgets/utils/gridbackground.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({
    Key? key,
  }) : super(key: key);

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  Widget build(BuildContext context) {
    List<Pill>? pills = Provider.of<DataModel>(context, listen: true).pill;
    return SliverStack(
      // defaults to false
      insetOnOverlap: true,
      children: <Widget>[
        const SliverPositioned.fill(
          child: GridBackground(),
        ),
        SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            sliver: SliverFillRemaining(
                child: ListView.separated(
                    itemCount: (pills != null) ? pills.length : 0,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      Pill pill = pills![index];
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Dismissible(
                              direction: DismissDirection.startToEnd,
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.all(20),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Remove',
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              key: UniqueKey(),
                              child: PillCard(
                                index: index,
                                pill: pill,
                                onTap: () {
                                  Future.microtask(() => Navigator.of(context)
                                          .pushNamed(RouteManager.detailsPage,
                                              arguments: {
                                            'pill': pill,
                                            'index': index
                                          }));
                                },
                              ),
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  Provider.of<DataModel>(context, listen: false)
                                      .removePill(pill);
                                });
                              }));
                    }))),
      ],
    );
  }
}

class PillCard extends StatelessWidget {
  const PillCard(
      {Key? key, required this.pill, required this.index, this.onTap})
      : super(key: key);

  final Pill pill;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        onTap?.call();
      }),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary)),
          child: Row(children: [
            Hero(
              tag: 'image' + index.toString(),
              child: Image.asset(
                "assets/images/Pill.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${pill.title}, 250mg',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Text(
                  '${pill.dosage} pill, once per day',
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.33),
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Iconsax.clock,
                      size: 18,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.33),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      pill.time.format(context),
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.33)),
                    )
                  ],
                )
              ],
            )
          ])),
    );
  }
}
