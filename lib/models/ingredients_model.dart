import 'hops_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'malt_model.dart';

part 'ingredients_model.g.dart';

@JsonSerializable(explicitToJson: true)
class IngredientsModel {
  final List<MaltModel> malt;
  final List<HopsModel> hops;
  final String? yeast;

  IngredientsModel({
    required this.malt,
    required this.hops,
    required this.yeast,
  });

  factory IngredientsModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientsModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientsModelToJson(this);
}
