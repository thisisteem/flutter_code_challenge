// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fermentation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FermentationModel _$FermentationModelFromJson(Map<String, dynamic> json) =>
    FermentationModel(
      temp: ValueUnitModel.fromJson(json['temp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FermentationModelToJson(FermentationModel instance) =>
    <String, dynamic>{
      'temp': instance.temp.toJson(),
    };
