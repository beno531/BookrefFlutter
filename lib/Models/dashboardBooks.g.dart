// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboardBooks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DashboardBooksAdapter extends TypeAdapter<DashboardBooks> {
  @override
  final int typeId = 1;

  @override
  DashboardBooks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DashboardBooks(
      (fields[0] as List)?.cast<Book>(),
      (fields[1] as List)?.cast<Book>(),
      (fields[2] as List)?.cast<Book>(),
    );
  }

  @override
  void write(BinaryWriter writer, DashboardBooks obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.currents)
      ..writeByte(1)
      ..write(obj.wishlist)
      ..writeByte(2)
      ..write(obj.library);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardBooksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
