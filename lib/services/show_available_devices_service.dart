import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class ShowAvailableDevicesService {
  static Future<List<BluetoothInfo>> showAvailableDevices() async {
    await Permission.bluetoothConnect.request();
    final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;
    if(listResult.isEmpty) {
      print('You need to pair your printer first');
      return [];
    } else {
      return listResult;
    }
  }
}
