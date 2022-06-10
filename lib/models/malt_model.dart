import 'value_unit_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'malt_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MaltModel {
  final String name;
  final ValueUnitModel amount;

  MaltModel({
    required this.name,
    required this.amount,
  });

  factory MaltModel.fromJson(Map<String, dynamic> json) =>
      _$MaltModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaltModelToJson(this);
}
