import 'package:flutter_code_challenge/models/beer/value_unit_model.dart';

class HopsModel {
  final String name;
  final ValueUnitModel amount;
  final String add;
  final String attribute;

  HopsModel({
    required this.name,
    required this.amount,
    required this.add,
    required this.attribute,
  });
}
