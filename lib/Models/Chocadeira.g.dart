// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Chocadeira.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChocadeiraAdapter extends TypeAdapter<Chocadeira> {
  @override
  final int typeId = 3;

  @override
  Chocadeira read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chocadeira(
      id: fields[1] as String,
      nome: fields[2] as String,
      bluetoothDevice: fields[3] as String,
      createdAt: fields[4] as DateTime?,
      updatedAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Chocadeira obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.nome)
      ..writeByte(3)
      ..write(obj.bluetoothDevice)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChocadeiraAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
