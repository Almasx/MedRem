import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lark/models/date.dart';
import 'package:lark/widgets/widgets.dart';
import 'package:lark/utils/stringext.dart';
import 'package:provider/provider.dart';

import '../models/pill.dart';

class FormPage extends StatefulWidget {
  FormPage({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formState = {
    'title': '',
    'weight': 0,
    'span': 0,
    'dosage': 0,
    'morning': null,
    'afternoon': null,
    'evening': null
  };
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
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
            'Add reminder',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Positioned.fill(
              child: GridBackground(),
            ),
            Positioned(
              top: 80,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Image.asset(
                  "assets/images/Pill.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            DraggableScrollableSheet(
                maxChildSize: .7,
                initialChildSize: .48,
                minChildSize: .48,
                builder: (context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 30, bottom: 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Theme.of(context).colorScheme.surface),
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -12,
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            width: 90,
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        SingleChildScrollView(
                          controller: scrollController,
                          child: Form(
                            key: widget._formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  titleForm(),
                                  weightForm(),
                                  amountAndSpanForm(),
                                  notificationsForm(),
                                  ButtonWidget(
                                      text: const Text(
                                        'Done',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      onPressed: () async {
                                        if (widget._formKey.currentState!
                                                .validate() &&
                                            [
                                              widget.formState['morning'],
                                              widget.formState['afternoon'],
                                              widget.formState['evening']
                                            ].any(
                                                (element) => element != null)) {
                                          widget._formKey.currentState?.save();
                                          List<TimeOfDay> times = [
                                            Map.from(
                                                widget.formState)['morning'],
                                            Map.from(
                                                widget.formState)['afternoon'],
                                            Map.from(
                                                widget.formState)['evening']
                                          ];
                                          for (TimeOfDay? time in times) {
                                            if (time == null) {
                                              continue;
                                            }
                                            widget.formState.keys
                                                .where((k) =>
                                                    'morning afternoon evening'
                                                        .contains(
                                                            k)) // filter keys
                                                .toList() // create a copy to avoid concurrent modifications
                                                .forEach(
                                                    widget.formState.remove);
                                            Pill pill = Pill.fromJson({
                                              ...widget.formState,
                                              'time': time
                                            });
                                            Provider.of<DataModel>(context,
                                                    listen: false)
                                                .add(pill);
                                          }
                                          // Navigator.of(context)
                                          //     .pushNamed(RouteManager.homePage);
                                        }
                                      })
                                ]),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ));
  }

  Column notificationsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['morning'] =
                          ((widget.formState['morning'] == null)
                              ? const TimeOfDay(hour: 7, minute: 0)
                              : null);
                    });
                  },
                  active: (widget.formState['morning'] != null),
                  text: '7:00 AM'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['afternoon'] =
                          ((widget.formState['afternoon'] == null)
                              ? const TimeOfDay(hour: 13, minute: 0)
                              : null);
                    });
                  },
                  active: (widget.formState['afternoon'] != null),
                  text: '1:00 PM'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['evening'] =
                          ((widget.formState['evening'] == null)
                              ? const TimeOfDay(hour: 19, minute: 0)
                              : null);
                    });
                  },
                  active: (widget.formState['evening'] != null),
                  text: '7:00 PM'),
            )
          ],
        ),
      ],
    );
  }

  Row amountAndSpanForm() {
    return Row(
      children: [
        Expanded(
          child: TextFieldWidget(
              onSave: (val) {
                setState(() {
                  widget.formState['amount'] = int.parse(val);
                });
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
              validator: (val) {
                if (val == null) {
                  return null;
                } else if (!val.isValidNumber) {
                  return 'Enter valid amount';
                }
                return null;
              },
              icon: Iconsax.copy,
              hint: '1 pill'),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFieldWidget(
              onSave: (val) {
                setState(() {
                  widget.formState['span'] = int.parse(val);
                });
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
              validator: (val) {
                if (val == null) {
                  return null;
                } else if (!val.isValidNumber) {
                  return 'Enter valid time interval';
                }
                return null;
              },
              icon: Iconsax.calendar_1,
              hint: '21 days'),
        )
      ],
    );
  }

  Column weightForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weight',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        TextFieldWidget(
            onSave: (val) {
              setState(() {
                widget.formState['weight'] = int.parse(val);
              });
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[0-9]"),
              )
            ],
            validator: (val) {
              if (val == null) {
                return null;
              } else if (!val.isValidNumber) {
                return 'Enter valid weight';
              }
              return null;
            },
            icon: Iconsax.weight,
            hint: '69 mg'),
        const Text(
          'Amount & How Long?',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }

  Column titleForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pills name',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        TextFieldWidget(
            onSave: (val) {
              setState(() {
                widget.formState['title'] = val;
              });
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[a-zA-Z]+|\s"),
              )
            ],
            validator: (val) {
              if (val == null) {
                return null;
              } else if (!val.isValidName) {
                return 'Enter valid Pill Name';
              }
              return null;
            },
            icon: Icons.medical_services_outlined,
            hint: 'Probiotic'),
      ],
    );
  }
}
