import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  String toHex({bool includeHashSign = true, bool withAlpha = true}) {
    final alpha = (a * 255).round().toRadixString(16).padLeft(2, '0');
    final red = (r * 255).round().toRadixString(16).padLeft(2, '0');
    final green = (g * 255).round().toRadixString(16).padLeft(2, '0');
    final blue = (b * 255).round().toRadixString(16).padLeft(2, '0');

    final hex = withAlpha ? '$alpha$red$green$blue' : '$red$green$blue';
    return includeHashSign ? '#${hex.toUpperCase()}' : hex.toUpperCase();
  }
}

extension ColorHexString on String {
  Color toColor() {
    final hex = replaceAll('#', '');
    final length = hex.length;

    if (length == 6) {
      return Color(int.parse('0xFF$hex'));
    } else if (length == 8) {
      return Color(int.parse('0x$hex'));
    } else {
      throw ArgumentError('Invalid hex color string: $this');
    }
  }
}