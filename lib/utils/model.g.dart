// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterData _$MasterDataFromJson(Map<String, dynamic> json) => MasterData(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MasterDataToJson(MasterData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isAttend: json['isAttend'] as bool,
      username: json['username'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      timestamps: json['timestamps'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'username': instance.username,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'timestamps': instance.timestamps,
      'distance': instance.distance,
      'isAttend': instance.isAttend,
    };
