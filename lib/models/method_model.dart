import 'package:json_annotation/json_annotation.dart';

import 'fermentation_model.dart';
import 'mash_temp_model.dart';

part 'method_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MethodModel {
  final List<MashTempModel> mashTemp;
  final FermentationModel fermentation;
  final String? twist;

  MethodModel({
    required this.mashTemp,
    required this.fermentation,
    this.twist,
  });

  factory MethodModel.fromJson(Map<String, dynamic> json) =>
      _$MethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$MethodModelToJson(this);
}
