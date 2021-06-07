// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillItemAdapter extends TypeAdapter<BillItem> {
  @override
  final int typeId = 100;

  @override
  BillItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillItem(
        fields[0] as String,
        fields[1] as double,
        fields[2] as DateTime,
        fields[4] as bool,
        fields[3] as String,
        fields[5] as bool,
        fields[6] as String,
        fields[40] as int);
  }

  @override
  void write(BinaryWriter writer, BillItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.cost)
      ..writeByte(2)
      ..write(obj.deadline)
      ..writeByte(3)
      ..write(obj.billDateStatus)
      ..writeByte(4)
      ..write(obj.isChecked)
      ..writeByte(5)
      ..write(obj.isPayed)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(40)
      ..write(obj.recurrence);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
