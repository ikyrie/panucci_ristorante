import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:panucci_ristorante/components/order_item.dart';
import 'package:panucci_ristorante/services/device_connect_service.dart';
import 'package:panucci_ristorante/services/show_available_devices_service.dart';
import 'package:panucci_ristorante/store/carrinho_store.dart';
import 'package:panucci_ristorante/viewmodels/checkout_viewmodel.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import '../components/payment_method.dart';
import '../components/payment_total.dart';

class Checkout extends StatelessWidget {
  Checkout({Key? key}) : super(key: key);
  final CheckoutViewmodel checkoutViewModel = CheckoutViewmodel();

  @override
  Widget build(BuildContext context) {
    final CarrinhoStore carrinhoStore = GetIt.instance.get<CarrinhoStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pedido",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
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
                        await checkoutViewModel.printReceipt(carrinhoStore.listaItem, carrinhoStore.totalDaCompra);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFFB81D27),),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.send, color: Colors.white,),
                            ),
                            Text(
                              "Enviar para cozinha",
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
