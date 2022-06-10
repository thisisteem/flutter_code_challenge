// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'method_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MethodModel _$MethodModelFromJson(Map<String, dynamic> json) => MethodModel(
      mashTemp: (json['mash_temp'] as List<dynamic>)
          .map((e) => MashTempModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      fermentation: FermentationModel.fromJson(
          json['fermentation'] as Map<String, dynamic>),
      twist: json['twist'] as String?,
    );

Map<String, dynamic> _$MethodModelToJson(MethodModel instance) =>
    <String, dynamic>{
      'mashTemp': instance.mashTemp.map((e) => e.toJson()).toList(),
      'fermentation': instance.fermentation.toJson(),
      'twist': instance.twist,
    };
