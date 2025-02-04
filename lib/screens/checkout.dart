import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:panucci_ristorante/components/order_item.dart';
import 'package:panucci_ristorante/services/device_connect_service.dart';
import 'package:panucci_ristorante/services/show_available_devices_service.dart';
import 'package:panucci_ristorante/store/carrinho_store.dart';
import 'package:panucci_ristorante/store/printer_settings_store.dart';
import 'package:panucci_ristorante/viewmodels/checkout_viewmodel.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:provider/provider.dart';
import '../components/payment_method.dart';
import '../components/payment_total.dart';

class Checkout extends StatelessWidget {
  Checkout({Key? key, required this.homeContext}) : super(key: key);
  final BuildContext homeContext;
  final CheckoutViewmodel checkoutViewModel = CheckoutViewmodel();

  @override
  Widget build(BuildContext context) {
    final CarrinhoStore carrinhoStore = Provider.of<CarrinhoStore>(homeContext, listen: false);
    final PrinterSettingsStore printerSettingsStore = Provider.of<PrinterSettingsStore>(homeContext, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Pedido",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return OrderItem(item: carrinhoStore.listaItem[index]);
                  },
                      childCount: carrinhoStore.listaItem.length)),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Pagamento",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: PaymentMethod(),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Confirmar",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: PaymentTotal(total: carrinhoStore.totalDaCompra),),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        List<BluetoothInfo> devices = await ShowAvailableDevicesService.showAvailableDevices();
                        await DeviceConnectionService.connect(devices[0].macAdress);
                        await checkoutViewModel.printReceipt(carrinhoStore.listaItem, carrinhoStore.totalDaCompra, printerSettingsStore.paperSize, printerSettingsStore.textSize);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).colorScheme.surfaceTint),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.account_balance_wallet),
                            ),
                            Text(
                              "Pedir",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ]),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
