import 'ingredients_model.dart';
import 'method_model.dart';
import 'value_unit_model.dart';

class BeerModel {
  final int id;
  final String name;
  final String tagline;
  final String firstBrewed;
  final String description;
  final String imageUrl;
  final double? abv;
  final double? ibu;
  final double? targetFg;
  final double? targetOg;
  final double? ebc;
  final double? srm;
  final double? ph;
  final double attenuationLevel;
  final ValueUnitModel volume;
  final ValueUnitModel boilVolume;
  final MethodModel method;
  final IngredientsModel ingredients;
  final List<String> foodPairing;
  final String brewersTips;
  final String contributedBy;

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
  });

  factory BeerModel.fromJson(Map<String, dynamic> json) => BeerModel(
        id: json["id"],
        name: json["name"],
        tagline: json["tagline"],
        firstBrewed: json["firstBrewed"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        abv: json["abv"],
        ibu: json["ibu"],
        targetFg: json["targetFg"],
        targetOg: json["targetOg"],
        ebc: json["ebc"],
        srm: json["srm"],
        ph: json["ph"],
        attenuationLevel: json["attenuationLevel"],
        volume: json["volume"],
        boilVolume: json["boilVolume"],
        method: json["method"],
        ingredients: json["ingredients"],
        foodPairing: json["foodPairing"],
        brewersTips: json["brewersTips"],
        contributedBy: json["contributedBy"],
      );
}
