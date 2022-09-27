import 'package:flutter/foundation.dart';
import 'package:lark/models/pill.dart';

import '../utils/network.dart';

class DataModel extends ChangeNotifier {
  Map<String, List<Pill>>? _pills = {};
  DateTime _selectedDate = DateTime(2022, 09, 26);

  List<Pill>? get pill => _pills?[datetimeformatter.format(_selectedDate)];

  Future<Map<String, List<Pill>>?> loadData() async {
    _pills = (await readPill()).cast<String, List<Pill>>();
    notifyListeners();
    return _pills;
  }

  set selectedDate(DateTime value) {
    if (value != _selectedDate) {
      _selectedDate = value;
      notifyListeners();
    }
  }

  DateTime get selectedDate => _selectedDate;

  void add(Pill pill) async {
    _pills = await writeData(pill);
    // print(_pills);
    notifyListeners();
  }

  void removePill(Pill pill) {
    _pills?[datetimeformatter.format(_selectedDate)]?.remove(pill);
    notifyListeners();
  }
}
