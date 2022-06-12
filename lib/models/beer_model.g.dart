// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeerModel _$BeerModelFromJson(Map<String, dynamic> json) => BeerModel(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: json['tagline'] as String,
      firstBrewed: json['first_brewed'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String?,
      abv: json['abv'] as num?,
      ibu: json['ibu'] as num?,
      targetFg: json['target_fg'] as num?,
      targetOg: json['target_og'] as num?,
      ebc: json['ebc'] as num?,
      srm: json['srm'] as num?,
      ph: json['ph'] as num?,
      attenuationLevel: json['attenuation_level'] as num?,
      volume: ValueUnitModel.fromJson(json['volume'] as Map<String, dynamic>),
      boilVolume:
          ValueUnitModel.fromJson(json['boil_volume'] as Map<String, dynamic>),
      method: MethodModel.fromJson(json['method'] as Map<String, dynamic>),
      ingredients: IngredientsModel.fromJson(
          json['ingredients'] as Map<String, dynamic>),
      foodPairing: (json['food_pairing'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      brewersTips: json['brewers_tips'] as String,
      contributedBy: json['contributed_by'] as String,
      isFavorite: false,
    );

Map<String, dynamic> _$BeerModelToJson(BeerModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tagline': instance.tagline,
      'firstBrewed': instance.firstBrewed,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'abv': instance.abv,
      'ibu': instance.ibu,
      'targetFg': instance.targetFg,
      'targetOg': instance.targetOg,
      'ebc': instance.ebc,
      'srm': instance.srm,
      'ph': instance.ph,
      'attenuationLevel': instance.attenuationLevel,
      'volume': instance.volume.toJson(),
      'boilVolume': instance.boilVolume.toJson(),
      'method': instance.method.toJson(),
      'ingredients': instance.ingredients.toJson(),
      'foodPairing': instance.foodPairing,
      'brewersTips': instance.brewersTips,
      'contributedBy': instance.contributedBy,
    };
