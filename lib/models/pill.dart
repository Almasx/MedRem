import 'package:flutter/material.dart';

class Pill {
  final TimeOfDay time;
  final String title;
  final String description;
  final int dosage;
  final int? span;
  final int weight;

  const Pill({
    this.span,
    required this.weight,
    required this.time,
    required this.title,
    required this.description,
    required this.dosage,
  });

  factory Pill.fromJson(Map<String, dynamic> json) {
    return Pill(
        weight: json['weight'] as int,
        span: json['span'] as int,
        time: json['time'] as TimeOfDay,
        description: json['description'],
        title: json['title'],
        dosage: json['dosage'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'span': span.toString(),
      'time': time.hour,
      'description': 'description',
      'title': title,
      'dosage': dosage
    };
  }
}
