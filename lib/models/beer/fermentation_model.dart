import 'package:flutter_code_challenge/models/beer/value_unit_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fermentation_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FermentationModel {
  final ValueUnitModel temp;

  FermentationModel({
    required this.temp,
  });

  factory FermentationModel.fromJson(Map<String, dynamic> json) =>
      _$FermentationModelFromJson(json);

  Map<String, dynamic> toJson() => _$FermentationModelToJson(this);
}
