import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class ShowPairedDevicesService {
  static Future<List<BluetoothInfo>> showPairedDevices() async {
    List<BluetoothInfo> devices = [];
    final bool isBluetoothEnabled = await PrintBluetoothThermal.bluetoothEnabled;
    if (isBluetoothEnabled) {
      try {
        devices = await PrintBluetoothThermal.pairedBluetooths;
      } catch (e) {
        print(e);
      }
    }
    return devices;
  }
}
