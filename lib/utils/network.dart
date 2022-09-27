import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lark/models/pill.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

var datetimeformatter = DateFormat('yyyy-MMM-dd');

Future<String> getDirPath() async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

Future<Map<String, dynamic>> readPill() async {
  Map<String, dynamic>? data = {};
  final _dirPath = await getDirPath();
  if (!File('$_dirPath/data.json').existsSync()) {
    File('$_dirPath/data.json').createSync(recursive: true);
  }
  final String rawData = File('$_dirPath/data.json').readAsStringSync();
  if (rawData.isNotEmpty) {
    Map<String, dynamic> raw = jsonDecode(rawData);
    for (String date in raw.keys) {
      List<dynamic> pills = raw[date];
      data[date] = List<Pill>.generate(pills.length, (index) {
        return Pill(
            span: int.parse(pills[index]['span']),
            time: TimeOfDay(hour: pills[index]['time'], minute: 0),
            description: "Lorem Ipsum",
            title: pills[index]['title'],
            dosage: pills[index]['dosage']);
      });
    }
  }

  print(data);
  return data;
}

Future<Map<String, List<Pill>>?> writeData(Pill data) async {
  final _dirPath = await getDirPath();
  final File _file = File('$_dirPath/data.json');
  Map<String, List<Pill>>? pillList =
      (await readPill()).cast<String, List<Pill>>();
  Map file = {};
  final dates = List<DateTime>.generate(
      data.span!,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(days: i)));
  for (DateTime date in dates) {
    String key = datetimeformatter.format(date);
    if (pillList.containsKey(key)) {
      pillList[key] = (pillList[key]! + [data]);
    } else {
      pillList[key] = [data];
    }
  }

  for (String date in pillList.keys) {
    List<Map> temp = [];
    for (var e in pillList[date]!) {
      temp.add(e.toJson());
    }
    file[date] = temp;
  }

  print(const JsonEncoder.withIndent("     ").convert(file));
  await _file.writeAsString(jsonEncode(file));
  return pillList;
}
