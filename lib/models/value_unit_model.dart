import 'package:json_annotation/json_annotation.dart';

part 'value_unit_model.g.dart';

@JsonSerializable()
class ValueUnitModel {
  final num value;
  final String unit;

  ValueUnitModel({
    required this.value,
    required this.unit,
  });

  factory ValueUnitModel.fromJson(Map<String, dynamic> json) =>
      _$ValueUnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$ValueUnitModelToJson(this);
}
