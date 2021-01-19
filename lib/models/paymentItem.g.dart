// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentDateStatusAdapter extends TypeAdapter<PaymentDateStatus> {
  @override
  final int typeId = 12;

  @override
  PaymentDateStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, PaymentDateStatus obj) {
    switch (obj) {
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentDateStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 13;

  @override
  Category read(BinaryReader reader) {
    switch (reader.readByte()) {
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    switch (obj) {
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaymentItemAdapter extends TypeAdapter<PaymentItem> {
  @override
  final int typeId = 11;

  @override
  PaymentItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentItem(
      fields[0] as String,
      fields[1] as double,
      fields[2] as DateTime,
      fields[4] as bool,
      fields[3] as PaymentDateStatus,
      fields[5] as bool,
      fields[6] as Category,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.cost)
      ..writeByte(2)
      ..write(obj.deadline)
      ..writeByte(3)
      ..write(obj.paymentDateStatus)
      ..writeByte(4)
      ..write(obj.isChecked)
      ..writeByte(5)
      ..write(obj.isPayed)
      ..writeByte(6)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
