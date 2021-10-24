import 'package:chocauto/Models/Auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Dash.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Dash extends HiveObject {
  @HiveField(1)
  final String id;
  @HiveField(2)
  final double temperetura;
  @HiveField(3)
  final double humidade;
  @HiveField(4)
  final double angulo;
  @HiveField(5)
  final DateTime horario;
  @HiveField(6)
  final DateTime createdAt;
  @HiveField(7)
  final DateTime updatedAt;
  
  @HiveField(8)
  final String chocadeiraId;

  @HiveField(9)
  final Auth auth;

  Dash(
      {required this.id,
      required this.temperetura,
      required this.humidade,
      required this.angulo,
      required this.horario,
      required this.createdAt,
      required this.updatedAt,
       required this.auth,
      required this.chocadeiraId
      });

  factory Dash.fromJson(Map<String, dynamic> json) => _$DashFromJson(json);
  Map<String, dynamic> toJson() => _$DashToJson(this);

  bool isEqual(Dash dash) {
    return (this.id == dash.id);
  }

  @override
  String toString() => this.toJson().toString();
}
