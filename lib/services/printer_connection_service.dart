import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class PrinterConnectionService {
  static Future<void> connect(String macAddress) async {
    final bool isBluetoothEnabled = await PrintBluetoothThermal.bluetoothEnabled;
    if (isBluetoothEnabled) {
      try {
        await PrintBluetoothThermal.connect(macPrinterAddress: macAddress);
      } catch(e) {
        print("Erro ao tentar se conectar com dispositivo: $e");
      }
    }
  }

  static Future<void> disconnect() async {
    final bool isDeviceConnected = await PrintBluetoothThermal.connectionStatus;
    if(isDeviceConnected) {
      await PrintBluetoothThermal.disconnect;
    }
  }
}
