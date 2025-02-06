import 'package:flutter/material.dart';

class PairedDevices extends StatelessWidget {
  const PairedDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dispositivos Pareados",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Text("Paired Devices"),
        ),
      ),
    );
  }
}
