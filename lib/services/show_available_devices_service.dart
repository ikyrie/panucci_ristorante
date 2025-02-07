import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class ShowAvailableDevicesService {
  static Future<List<BluetoothInfo>> showAvailableDevices() async {
    final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;
    if(listResult.isEmpty) {
      print('You need to pair your printer first');
      return [];
    } else {
      return listResult;
    }
  }
}
