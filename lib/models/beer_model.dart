import 'package:json_annotation/json_annotation.dart';

import 'ingredients_model.dart';
import 'method_model.dart';
import 'value_unit_model.dart';

part 'beer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BeerModel {
  final int id;
  final String name;
  final String tagline;
  final String firstBrewed;
  final String description;
  final String imageUrl;
  final num? abv;
  final num? ibu;
  final num? targetFg;
  final num? targetOg;
  final num? ebc;
  final num? srm;
  final num? ph;
  final num attenuationLevel;
  final ValueUnitModel volume;
  final ValueUnitModel boilVolume;
  final MethodModel method;
  final IngredientsModel ingredients;
  final List<String> foodPairing;
  final String brewersTips;
  final String contributedBy;
  bool isFavorite;

  BeerModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.firstBrewed,
    required this.description,
    required this.imageUrl,
    this.abv,
    this.ibu,
    this.targetFg,
    this.targetOg,
    this.ebc,
    this.srm,
    this.ph,
    required this.attenuationLevel,
    required this.volume,
    required this.boilVolume,
    required this.method,
    required this.ingredients,
    required this.foodPairing,
    required this.brewersTips,
    required this.contributedBy,
    required this.isFavorite,
  });

  factory BeerModel.fromJson(Map<String, dynamic> json) =>
      _$BeerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BeerModelToJson(this);
}
