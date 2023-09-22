import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class IconDataAdapter extends TypeAdapter<IconData?> {
  @override
  final int typeId = 1; // Assign a unique type ID to IconData

  @override
  IconData? read(BinaryReader reader) {
    final codePoint = reader.readInt();
    final fontFamily = reader.readString();
    return IconData(codePoint, fontFamily: fontFamily);
  }

  @override
  void write(BinaryWriter writer, IconData? icon) {
    if (icon != null) {
      writer.writeInt(icon.codePoint);
      writer.writeString(icon.fontFamily ?? 'MaterialIcons');
    } else {
      writer.writeInt(0); // Write a default value for codePoint
      writer.writeString(''); // Write an empty string for fontFamily
    }
  }
}
