import 'package:consulta_cep/compartilhados/padrao_imagens.dart';
import 'package:consulta_cep/pagina/busca_cep_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Consulta CEP"), centerTitle: true),
        backgroundColor: Colors.blueAccent,
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BuscaCepPage(),
                          ),
                        );
                      },

                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(PadraoImagens.consulta_cep),
                              ),
                              Text('Consulta CEP'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("hitorico cep");
                        // Navigator.push(
                        // context,
                        // MaterialPageRoute(
                        // builder: (context) => HistoricoImcPage(),
                        // ),
                        // );
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(PadraoImagens.historico_cep),
                              ),
                              Text('Historico de CEP'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 3, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
