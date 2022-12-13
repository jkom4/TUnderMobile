// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synthese.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Synthese _$SyntheseFromJson(Map<String, dynamic> json) => Synthese(
      json['id'] as int,
      json['creationDate'] == null
          ? null
          : DateTime.parse(json['creationDate'] as String),
      json['url'] as String,
      json['autheurOf'] as String?,
      Cours.fromJson(json['cours'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SyntheseToJson(Synthese instance) => <String, dynamic>{
      'id': instance.id,
      'creationDate': instance.creationDate?.toIso8601String(),
      'url': instance.url,
      'autheurOf': instance.autheurOf,
      'cours': instance.cours,
    };
