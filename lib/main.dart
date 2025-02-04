import 'package:flutter/material.dart';
import 'package:panucci_ristorante/screens/home.dart';
import 'package:panucci_ristorante/store/carrinho_store.dart';
import 'package:panucci_ristorante/store/printer_settings_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PanucciDelivery());
}

class PanucciDelivery extends StatelessWidget {
const PanucciDelivery({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 83, 83), ), useMaterial3: true),
      home: MultiProvider(providers: <Provider>[
        Provider<CarrinhoStore>(create: (_) => CarrinhoStore()),
        Provider<PrinterSettingsStore>(create: (_) => PrinterSettingsStore()),
      ],child: Home(),),
    );
  }
}
