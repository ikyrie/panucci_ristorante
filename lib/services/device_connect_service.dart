import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

abstract class DeviceConnectionService {
  static Future<void> connect(String macPrinterAddress) async {
    if(await PrintBluetoothThermal.bluetoothEnabled) {
      if(await PrintBluetoothThermal.connectionStatus) {
        print(await PrintBluetoothThermal.connectionStatus);
        print('Already connected');
      } else {
        print(await PrintBluetoothThermal.connectionStatus);
        await PrintBluetoothThermal.connect(macPrinterAddress: macPrinterAddress);
      }
    }
  }

  static Future<void> disconnect() async {
    await PrintBluetoothThermal.disconnect;
  }
}
