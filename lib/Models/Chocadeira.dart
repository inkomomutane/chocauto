import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:json_annotation/json_annotation.dart';
part 'Chocadeira.g.dart';

//@JsonSerializable()
@HiveType(typeId: 3)
class Chocadeira extends HiveObject {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String nome;
  @HiveField(3)
  final String bluetoothDevice;
  @HiveField(4)
  final DateTime? createdAt;
  @HiveField(5)
  final DateTime updatedAt;

  Chocadeira(
      {required this.id,
      required this.nome,
      required this.bluetoothDevice,
      required this.createdAt,
      required this.updatedAt});

  bool isEqual(Chocadeira chocadeira) {
    return (this.id == chocadeira.id);
  }

  @override
  String toString() => this.toString();
}
