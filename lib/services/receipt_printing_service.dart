import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:panucci_ristorante/utils/printer_settings_utils.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceiptPrintingService {

  static Future<void> printReceipt(List<int> bytes) async {
    final bool isDeviceConnected = await PrintBluetoothThermal.connectionStatus;
    if(isDeviceConnected) {
      await PrintBluetoothThermal.writeBytes(bytes);
    } else {
      print("Dispositivo não conectado");
    }
  }

  static Future<void> printingTest() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final PaperSize paperSize = PaperSizeUtils.getPaperSize(preferences.getInt("paperSize")!);
    final bool isDeviceConnected = await PrintBluetoothThermal.connectionStatus;
    final CapabilityProfile profile = await CapabilityProfile.load();
    final Generator generator = Generator(paperSize, profile);
    List<int> bytes = [];
    if(isDeviceConnected) {
      bytes += generator.text("Teste de impressão", styles: PosStyles(align: PosAlign.center, height: PosTextSize.size2, bold: false));
      bytes += generator.feed(2);
      bytes += generator.reset();
      bytes += generator.text("Teste de impressão", styles: PosStyles(align: PosAlign.right, height: PosTextSize.size1));
      bytes += generator.reset();
      bytes += generator.text("Teste de impressão", styles: PosStyles(align: PosAlign.left, height: PosTextSize.size1, bold: true));
      bytes += generator.reset();

      await PrintBluetoothThermal.writeBytes(bytes);
    }
  }
}
