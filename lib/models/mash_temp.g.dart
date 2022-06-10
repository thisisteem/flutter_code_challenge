// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mash_temp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MashTempModel _$MashTempModelFromJson(Map<String, dynamic> json) =>
    MashTempModel(
      temp: ValueUnitModel.fromJson(json['temp'] as Map<String, dynamic>),
      duration: json['duration'] as num?,
    );

Map<String, dynamic> _$MashTempModelToJson(MashTempModel instance) =>
    <String, dynamic>{
      'temp': instance.temp.toJson(),
      'duration': instance.duration,
    };
