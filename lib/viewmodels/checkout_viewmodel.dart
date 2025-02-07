import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:panucci_ristorante/models/item.dart';
import 'package:panucci_ristorante/services/printing_service.dart';

class CheckoutViewmodel {

  Future<void> printReceipt(List<Item> items, double total) async {
    final CapabilityProfile profile = await CapabilityProfile.load();
    List<int> bytes = _prepareReceit(items, total, profile);
    await PrintingService.printReceipt(bytes);
  }

  List<int> _prepareReceit(List<Item> items, double total, CapabilityProfile profile) {
    List<int> bytes = [];
    Generator generator = Generator(PaperSize.mm58, profile);

    bytes += generator.feed(3);
    bytes += generator.text("Panucci Ristorante", styles: const PosStyles(align: PosAlign.center, height: PosTextSize.size2));
    bytes += generator.feed(2);
    bytes += generator.qrcode('https://panucci.com.br', size: QRSize.size7);
    bytes += generator.feed(2);
    for (Item item in items) {
      bytes += generator.row([
        PosColumn(text: item.nome, width: 6, styles: PosStyles(align: PosAlign.left)),
        PosColumn(text: "R\$ ${item.preco.toStringAsFixed(2)}", width: 6, styles: PosStyles(align: PosAlign.right))
      ]);
    }
    bytes += generator.feed(2);
    bytes += generator.hr();
    bytes += generator.text("Total: R\$ ${total.toStringAsFixed(2)}", styles: const PosStyles(align: PosAlign.right));
    bytes += generator.feed(3);
    return bytes;
  }
}
