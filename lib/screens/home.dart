import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:panucci_ristorante/components/item_list.dart';
import 'package:panucci_ristorante/screens/checkout.dart';
import 'package:panucci_ristorante/screens/paired_devices.dart';
import 'package:panucci_ristorante/store/carrinho_store.dart';
import '../components/categoria_text.dart';
import '../components/search_input.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final TextEditingController searchTextController = TextEditingController();
  final CarrinhoStore carrinhoStore = GetIt.instance.get<CarrinhoStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cardápio",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PairedDevices()));
            },
            icon: Icon(Icons.print),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                  child:
                      SearchInput(searchTextController: searchTextController)),
              const SliverToBoxAdapter(
                  child: CategoriaText(titulo: "Mais comprados")),
              const SliverToBoxAdapter(
                child: ItemList(categoria: "mais comprados"),
              ),
              const SliverToBoxAdapter(
                  child: CategoriaText(titulo: "Para o almoço")),
              const SliverToBoxAdapter(
                child: ItemList(categoria: "para o almoço"),
              ),
              const SliverToBoxAdapter(
                  child: CategoriaText(titulo: "Para dividir")),
              const SliverToBoxAdapter(
                child: ItemList(categoria: "para dividir"),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 70),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Observer(
              builder: (_) => !carrinhoStore.listaVazia
                  ? InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Checkout();
                        }));
                      },
                      child: Container(
                          width: double.infinity,
                          height: 80,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Color(0xFFB81D27),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10))),
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "${carrinhoStore.quantidadeItem}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                  ),
                                  Icon(
                                    Icons.list_alt,
                                    size: 24,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Ver pedido",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "R\$ ${carrinhoStore.totalDaCompra.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                            ),
                          ])),
                    )
                  : Container(),
            ),
          )
        ]),
      ),
    );
  }
}


