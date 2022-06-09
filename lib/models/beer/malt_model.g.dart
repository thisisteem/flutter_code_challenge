// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'malt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaltModel _$MaltModelFromJson(Map<String, dynamic> json) => MaltModel(
      name: json['name'] as String,
      amount: ValueUnitModel.fromJson(json['amount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MaltModelToJson(MaltModel instance) => <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount.toJson(),
    };
