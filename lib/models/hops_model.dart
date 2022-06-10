import 'value_unit_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hops_model.g.dart';

@JsonSerializable(explicitToJson: true)
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

  factory HopsModel.fromJson(Map<String, dynamic> json) =>
      _$HopsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HopsModelToJson(this);
}
