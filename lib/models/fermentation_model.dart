import 'package:json_annotation/json_annotation.dart';

import 'value_unit_model.dart';

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
