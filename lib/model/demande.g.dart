// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demande.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Demande _$DemandeFromJson(Map<String, dynamic> json) => Demande(
      json['id'] as int,
      json['etat'] as String,
      json['commentaire'] as String?,
      json['demandeur'] as String?,
      json['gestionnaire'] as String?,
      Cours.fromJson(json['cours'] as Map<String, dynamic>),
      json['rencontre'] == null
          ? null
          : Rencontre.fromJson(json['rencontre'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DemandeToJson(Demande instance) => <String, dynamic>{
      'id': instance.id,
      'commentaire': instance.commentaire,
      'etat': instance.etat,
      'gestionnaire': instance.gestionnaire,
      'demandeur': instance.demandeur,
      'cours': instance.cours.toJson(),
      'rencontre': instance.rencontre.toJson(),
    };
