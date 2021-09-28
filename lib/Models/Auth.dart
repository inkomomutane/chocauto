
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part  'Auth.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Auth extends HiveObject {
  @HiveField(1)

  final String username;
  @HiveField(2)
  final String password;
  Auth({required this.username, required this.password});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);

  bool isEqual(Auth auth) {
    return (this.username == auth.username && this.password == auth.password);
  }

  @override
  String toString() => "{ Username: ${this.username}, Password: ${this.password} }";
}
