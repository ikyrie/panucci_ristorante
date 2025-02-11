import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class ReceiptPrintingService {

  static Future<void> printReceipt(List<int> bytes) async {
    final bool isDeviceConnected = await PrintBluetoothThermal.connectionStatus;
    if(isDeviceConnected) {
      await PrintBluetoothThermal.writeBytes(bytes);
    } else {
      print("Dispositivo não conectado");
    }
  }
}
