import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:panucci_ristorante/models/item.dart';
import 'package:panucci_ristorante/services/receipt_printing_service.dart';
import 'package:panucci_ristorante/utils/printer_settings_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutViewmodel {

  Future<void> printReceipt(List<Item> items, double total) async {
    await ReceiptPrintingService.printReceipt(await _generateReceipt(items, total));
  }

  Future<List<int>> _generateReceipt(List<Item> items, double total) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    PaperSize paperSize = PaperSizeUtils.getPaperSize(preferences.getInt("paperSize")!);
    PosTextSize textSize = TextSizeUtils.getTextSize(preferences.getInt("textSize")!);

    List<int> bytes = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(paperSize, profile);

    bytes += generator.text('Panucci Ristorante', styles: const PosStyles(align: PosAlign.center, height: PosTextSize.size2));
    bytes += generator.reset();
    bytes += generator.feed(2);
    bytes += generator.qrcode("https://panucciristante.com.br", size: QRSize.size8);
    bytes += generator.feed(2);
    for(var item in items) {
      bytes += generator.row([PosColumn(text: item.nome, width: 6, styles: PosStyles(align: PosAlign.left, height: textSize)),PosColumn(text: item.preco.toStringAsFixed(2), width: 6, styles: PosStyles(align: PosAlign.right, height: textSize))]);
    }
    bytes += generator.feed(1);
    bytes += generator.hr();
    bytes += generator.feed(1);
    bytes += generator.reset();
    bytes += generator.row([PosColumn(text: "Total:", width: 6, styles: PosStyles(align: PosAlign.left, height: textSize)),PosColumn(text: total.toStringAsFixed(2), width: 6, styles: PosStyles(align: PosAlign.right, height: textSize))]);
    bytes += generator.feed(3);

    return bytes;
  }
}
