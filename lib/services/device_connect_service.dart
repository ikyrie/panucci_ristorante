import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

abstract class DeviceConnectionService {
  static Future<void> connect(String macPrinterAddress) async {
    await Permission.bluetoothScan.request();
    if(await PrintBluetoothThermal.bluetoothEnabled) {
      if(await PrintBluetoothThermal.connectionStatus) {
        print('Already connected');
      } else {
        await PrintBluetoothThermal.connect(macPrinterAddress: macPrinterAddress);
      }
    }
  }

  static Future<void> disconnect() async {
    await PrintBluetoothThermal.disconnect;
  }
}
