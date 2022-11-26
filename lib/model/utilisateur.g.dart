// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilisateur.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Utilisateur _$UtilisateurFromJson(Map<String, dynamic> json) => Utilisateur(
      json['prenom'] as String,
      json['nom'] as String,
      json['email'] as String,

    );

Map<String, dynamic> _$UtilisateurToJson(Utilisateur instance) =>
    <String, dynamic>{
      'prenom': instance.prenom,
      'nom': instance.nom,
      'email': instance.email,
    };
