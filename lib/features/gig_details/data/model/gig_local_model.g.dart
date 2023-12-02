// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gig_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GigLocalModelAdapter extends TypeAdapter<GigLocalModel> {
  @override
  final int typeId = 0;

  @override
  GigLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GigLocalModel(
      id: fields[0] as String,
      title: fields[1] as String,
      image: fields[2] as String,
      price: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GigLocalModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GigLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
