
import 'package:MusicApp/Feature/mp3Access.dart';
import 'package:flutter/material.dart';

class ParentdWidget extends InheritedWidget {
  final Mp3Access fileData;
  final bool isLoading;

  const ParentdWidget(this.fileData, this.isLoading, child)
      : super(child: child);

  static ParentdWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(ParentdWidget oldWidget) =>
      fileData != oldWidget.fileData || isLoading != oldWidget.isLoading;
}