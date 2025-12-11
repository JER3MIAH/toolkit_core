import 'package:flutter/material.dart';

extension StringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  String capitalize() {
    if (isNullOrEmpty) return '';
    return this![0].toUpperCase() + this!.substring(1);
  }

  String toTitleCase() {
    if (isNullOrEmpty) return '';
    return this!.split(' ').map((word) => word.capitalize()).join(' ');
  }

  String removeSpaces() => this?.replaceAll(' ', '') ?? '';

  int toIntOrZero() => int.tryParse(this ?? '') ?? 0;
  double toDoubleOrZero() => double.tryParse(this ?? '') ?? 0.0;

  /// Convert "#RRGGBB" to Flutter Color
  Color get asColor {
    if (isNullOrEmpty) return const Color(0xFF000000);
    final hex = this!.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}
