import 'package:flutter/material.dart';

ebcToColorCode(ebc) {
  // ref -> https://www.saveur-biere.com/en/magazine/brewing/4/white-blonde-ruby-brown-beer-in-every-colour/58

  if (ebc == null) {
    return Colors.transparent;
  } else {
    if (ebc <= 4) {
      return HexColor("#F7F761");
    } else if (ebc <= 6) {
      return HexColor("#F6F53D");
    } else if (ebc <= 8) {
      return HexColor("#E9E53C");
    } else if (ebc <= 12) {
      return HexColor("#CDBB3B");
    } else if (ebc <= 16) {
      return HexColor("#B19242");
    } else if (ebc <= 20) {
      return HexColor("#B08042");
    } else if (ebc <= 26) {
      return HexColor("#A76739");
    } else if (ebc <= 33) {
      return HexColor("#7D4D36");
    } else if (ebc <= 39) {
      return HexColor("#533721");
    } else if (ebc <= 47) {
      return HexColor("#271D1C");
    } else if (ebc <= 57) {
      return HexColor("#171312");
    } else if (ebc <= 69) {
      return HexColor("#101010");
    } else if (ebc <= 79) {
      return HexColor("#0C0C0C");
    } else if (ebc <= 138) {
      return HexColor("#000000");
    } else {
      return HexColor("#000000");
    }
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
