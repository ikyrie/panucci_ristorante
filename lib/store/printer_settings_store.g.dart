// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PrinterSettingsStore on _PrinterSettingsStore, Store {
  late final _$paperSizeAtom =
      Atom(name: '_PrinterSettingsStore.paperSize', context: context);

  @override
  PaperSize get paperSize {
    _$paperSizeAtom.reportRead();
    return super.paperSize;
  }

  @override
  set paperSize(PaperSize value) {
    _$paperSizeAtom.reportWrite(value, super.paperSize, () {
      super.paperSize = value;
    });
  }

  late final _$textSizeAtom =
      Atom(name: '_PrinterSettingsStore.textSize', context: context);

  @override
  PosTextSize get textSize {
    _$textSizeAtom.reportRead();
    return super.textSize;
  }

  @override
  set textSize(PosTextSize value) {
    _$textSizeAtom.reportWrite(value, super.textSize, () {
      super.textSize = value;
    });
  }

  late final _$_PrinterSettingsStoreActionController =
      ActionController(name: '_PrinterSettingsStore', context: context);

  @override
  void setPaperSize(PaperSize paperSize) {
    final _$actionInfo = _$_PrinterSettingsStoreActionController.startAction(
        name: '_PrinterSettingsStore.setPaperSize');
    try {
      return super.setPaperSize(paperSize);
    } finally {
      _$_PrinterSettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTextSize(PosTextSize textSize) {
    final _$actionInfo = _$_PrinterSettingsStoreActionController.startAction(
        name: '_PrinterSettingsStore.setTextSize');
    try {
      return super.setTextSize(textSize);
    } finally {
      _$_PrinterSettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
paperSize: ${paperSize},
textSize: ${textSize}
    ''';
  }
}
