import 'value_unit_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mash_temp_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MashTempModel {
  final ValueUnitModel temp;
  final num? duration;

  MashTempModel({
    required this.temp,
    required this.duration,
  });

  factory MashTempModel.fromJson(Map<String, dynamic> json) =>
      _$MashTempModelFromJson(json);

  Map<String, dynamic> toJson() => _$MashTempModelToJson(this);
}
