import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:panucci_ristorante/services/printer_connection_service.dart';
import 'package:panucci_ristorante/services/receipt_printing_service.dart';
import 'package:panucci_ristorante/services/show_paired_devices_service.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class CheckoutViewmodel {

  Future<void> printReceipt() async {

    List<BluetoothInfo> devices = await ShowPairedDevicesService.showPairedDevices();
    await PrinterConnectionService.connect(devices[0].macAdress);

    await ReceiptPrintingService.printReceipt(await _generateReceipt());
  }

  Future<List<int>> _generateReceipt() async {
    List<int> bytes = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    bytes += generator.text("Um item da comanda",
        linesAfter: 2,
        styles: PosStyles(align: PosAlign.center, height: PosTextSize.size1));
    bytes += generator.reset();
    bytes += generator.text("Um item da comanda",
        linesAfter: 2, styles: PosStyles(height: PosTextSize.size2));
    bytes += generator.reset();
    bytes += generator.row([
      PosColumn(
          text: "Item 1", width: 6, styles: PosStyles(align: PosAlign.left)),
      PosColumn(
          text: "Item 2", width: 6, styles: PosStyles(align: PosAlign.right))
    ]);
    bytes += generator.reset();
    bytes += generator.text("Um texto em negrito",
        styles: PosStyles(fontType: PosFontType.fontB));
    bytes += generator.reset();
    bytes += generator.qrcode("Um site qualquer.com", size: QRSize.size8);
    bytes += generator.reset();

    return bytes;
  }
}
