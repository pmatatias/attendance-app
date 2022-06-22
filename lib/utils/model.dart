import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class MasterData {
  String? name;
  double? latitude, longitude;

  MasterData({
    this.latitude,
    this.longitude,
    this.name,
  });
  factory MasterData.fromJson(Map<String, dynamic> json) =>
      _$MasterDataFromJson(json);
  Map<String, dynamic> toJson() => _$MasterDataToJson(this);

  void setLat(double lat) {
    latitude = lat;
  }

  void setLang(double lang) {
    longitude = lang;
  }
}

@JsonSerializable()
class UserData {
  String? username;
  double latitude, longitude;
  String? timestamps;
  double? distance;
  bool isAttend = false;

  UserData({
    required this.latitude,
    required this.longitude,
    required this.isAttend,
    this.username,
    this.distance,
    this.timestamps,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
