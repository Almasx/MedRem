import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lark/models/pill.dart';
import 'package:lark/utils/network.dart';
import 'package:path_provider/path_provider.dart';

var datetimeformatter = DateFormat('yyyy-MMM-dd');
Future<void> main() async {
  runApp(const App());
  final dir = (await getApplicationDocumentsDirectory()).path;
  File('$dir/data.json').writeAsStringSync('');
  Map<String, dynamic> formState = {
    'title': 'Furcilin',
    'weight': 15,
    'span': 4,
    'dosage': 2,
    'morning': const TimeOfDay(hour: 7, minute: 0),
    'afternoon': const TimeOfDay(hour: 13, minute: 0),
    'evening': const TimeOfDay(hour: 19, minute: 0)
  };

  List<TimeOfDay> times = [
    Map.from(formState)['morning'],
    Map.from(formState)['afternoon'],
    Map.from(formState)['evening']
  ];
  formState.remove('morning');
  formState.remove('afternoon');
  formState.remove('evening');

  for (TimeOfDay? time in times) {
    if (time == null) {
      continue;
    }
    Pill pill = Pill.fromJson({...formState, 'time': time});
    await writeData(pill);
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
