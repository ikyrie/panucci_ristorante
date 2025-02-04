import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

abstract class PrintingService {
  static Future<void> printReceipt(List<int> bytes) async {
    try {
      await PrintBluetoothThermal.writeBytes(bytes);
    } catch (e) {
      print("Error printing: $e");
    }
  }
}
