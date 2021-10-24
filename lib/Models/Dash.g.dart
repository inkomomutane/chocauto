// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Dash.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DashAdapter extends TypeAdapter<Dash> {
  @override
  final int typeId = 2;

  @override
  Dash read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dash(
      id: fields[1] as String,
      temperetura: fields[2] as double,
      humidade: fields[3] as double,
      angulo: fields[4] as double,
      horario: fields[5] as DateTime,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
      auth: fields[9] as Auth,
      chocadeiraId: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dash obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.temperetura)
      ..writeByte(3)
      ..write(obj.humidade)
      ..writeByte(4)
      ..write(obj.angulo)
      ..writeByte(5)
      ..write(obj.horario)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.chocadeiraId)
      ..writeByte(9)
      ..write(obj.auth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dash _$DashFromJson(Map<String, dynamic> json) {
  return Dash(
    id: json['id'] as String,
    temperetura: (json['temperetura'] as num).toDouble(),
    humidade: (json['humidade'] as num).toDouble(),
    angulo: (json['angulo'] as num).toDouble(),
    horario: DateTime.parse(json['horario'] as String),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    auth: Auth.fromJson(json['auth'] as Map<String, dynamic>),
    chocadeiraId: json['chocadeiraId'] as String,
  );
}

Map<String, dynamic> _$DashToJson(Dash instance) => <String, dynamic>{
      'id': instance.id,
      'temperetura': instance.temperetura,
      'humidade': instance.humidade,
      'angulo': instance.angulo,
      'horario': instance.horario.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'chocadeiraId': instance.chocadeiraId,
      'auth': instance.auth,
    };
