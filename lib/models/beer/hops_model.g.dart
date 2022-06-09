// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hops_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HopsModel _$HopsModelFromJson(Map<String, dynamic> json) => HopsModel(
      name: json['name'] as String,
      amount: ValueUnitModel.fromJson(json['amount'] as Map<String, dynamic>),
      add: json['add'] as String,
      attribute: json['attribute'] as String,
    );

Map<String, dynamic> _$HopsModelToJson(HopsModel instance) => <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount.toJson(),
      'add': instance.add,
      'attribute': instance.attribute,
    };
