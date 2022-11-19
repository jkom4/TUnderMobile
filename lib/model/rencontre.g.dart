// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rencontre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rencontre _$RencontreFromJson(Map<String, dynamic> json) => Rencontre(
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      json['addresse'] as String?,
    );

Map<String, dynamic> _$RencontreToJson(Rencontre instance) => <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'addresse': instance.addresse,
    };
