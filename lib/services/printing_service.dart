import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class PrintingService {
  static Future<void> printReceipt(List<int> bytes) async {
    try {
      await PrintBluetoothThermal.writeBytes(bytes);
    } catch (e) {
      print("Error printing: $e");
    }
  }

  static Future<void> testPrinting(PaperSize paperSize) async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();

    Generator generator =
        Generator(paperSize, profile);

    bytes += generator.feed(3);
    bytes += generator.text(
      "Print Test",
      styles:
          const PosStyles(align: PosAlign.center, height: PosTextSize.size2),
    );
    bytes += generator.feed(2);
    bytes += generator.qrcode('https://panucci.com.br', size: QRSize.size7);
    bytes += generator.feed(2);
    bytes += generator.text("Font Size 1", styles: PosStyles(height: PosTextSize.size1));
    bytes += generator.text("Font Size 2", styles: PosStyles(height: PosTextSize.size2));
    bytes += generator.text("Font Size 3", styles: PosStyles(height: PosTextSize.size3));
    bytes += generator.text("Font Size 4", styles: PosStyles(height: PosTextSize.size4));
    bytes += generator.text("Font Size 5", styles: PosStyles(height: PosTextSize.size5));
    bytes += generator.text("Font Size 6", styles: PosStyles(height: PosTextSize.size6));
    bytes += generator.text("Font Size 7", styles: PosStyles(height: PosTextSize.size7));
    bytes += generator.text("Font Size 8", styles: PosStyles(height: PosTextSize.size8));
    bytes += generator.feed(3);
    
    printReceipt(bytes);
  }
}
