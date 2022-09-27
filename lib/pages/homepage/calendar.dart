import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/date.dart';

class CalendarDelegate extends SliverPersistentHeaderDelegate {
  int _selectedPill = 0;

  @override
  double get maxExtent => 158;

  @override
  double get minExtent => 158;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return StatefulBuilder(
        builder: (context, setState) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.secondary),
                bottom: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 24,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'September ',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          TextSpan(
                            text: '2022',
                          ),
                        ],
                      ),
                    ),
                    const Icon(Iconsax.arrow_right_3)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  ...List<Expanded>.generate(
                      7,
                      (index) => Expanded(
                            child: DatePill(
                              date: DateTime.utc(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              ).add(Duration(days: index)),
                              onPressed: () {
                                setState(() {
                                  _selectedPill = index;
                                });
                              },
                              active: index == _selectedPill,
                            ),
                          ))
                ])
              ],
            )));
  }
}

class DatePill extends StatelessWidget {
  const DatePill(
      {Key? key, this.onPressed, this.active = false, required this.date})
      : super(key: key);
  final VoidCallback? onPressed;
  final DateTime date;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              onPressed?.call();

              Provider.of<DataModel>(context, listen: false).selectedDate =
                  date;
              print(
                  Provider.of<DataModel>(context, listen: false).selectedDate);
            },
            child: Container(
              decoration: active
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary))
                  : null,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(children: [
                Text(DateFormat('d').format(date),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(active ? 1 : 0.66))),
                Text(
                  DateFormat('EEE').format(date).substring(0, 3).toLowerCase(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(active ? 1 : 0.66)),
                )
              ]),
            ),
          )),
    );
  }
}
