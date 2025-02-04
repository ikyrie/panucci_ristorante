import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:mobx/mobx.dart';

part 'printer_settings_store.g.dart';

class PrinterSettingsStore = _PrinterSettingsStore with _$PrinterSettingsStore;

abstract class _PrinterSettingsStore with Store {
  @observable
  PaperSize paperSize = PaperSize.mm58;

  @observable
  PosTextSize textSize = PosTextSize.size1;

  @action
  void setPaperSize(PaperSize paperSize) {
    this.paperSize = paperSize;
  }

  @action
  void setTextSize(PosTextSize textSize) {
    this.textSize = textSize;
  }
}
