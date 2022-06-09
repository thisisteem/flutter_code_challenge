// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredients_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientsModel _$IngredientsModelFromJson(Map<String, dynamic> json) =>
    IngredientsModel(
      malt: (json['malt'] as List<dynamic>)
          .map((e) => MaltModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hops: (json['hops'] as List<dynamic>)
          .map((e) => HopsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      yeast: json['yeast'] as String,
    );

Map<String, dynamic> _$IngredientsModelToJson(IngredientsModel instance) =>
    <String, dynamic>{
      'malt': instance.malt.map((e) => e.toJson()).toList(),
      'hops': instance.hops.map((e) => e.toJson()).toList(),
      'yeast': instance.yeast,
    };
