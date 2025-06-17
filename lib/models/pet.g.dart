// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetAdapter extends TypeAdapter<Pet> {
  @override
  final int typeId = 0;

  @override
  Pet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pet(
      id: fields[0] as String,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      age: fields[3] as int,
      price: fields[4] as int,
      isAdopted: fields[5] as bool,
      isFavorite: fields[6] as bool,
      category: fields[7] as String,
      imageBytes: fields[8] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, Pet obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.isAdopted)
      ..writeByte(6)
      ..write(obj.isFavorite)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.imageBytes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
