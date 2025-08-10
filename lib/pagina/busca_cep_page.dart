import 'package:consulta_cep/modelo/b4a_cep_modelo.dart';
import 'package:consulta_cep/modelo/via_cep_modelo.dart';
import 'package:consulta_cep/repositorio/via_cep_repositorio.dart';
import 'package:flutter/material.dart';

class BuscaCepPage extends StatefulWidget {
  const BuscaCepPage({super.key});

  @override
  State<BuscaCepPage> createState() => _BuscaCepPageState();
}

class _BuscaCepPageState extends State<BuscaCepPage> {
  var cepController = TextEditingController(text: "");
  var cepB4a = B4aCepModelo([]);
  var carregando = false;
  var viaCepModelo = ViaCepModelo();
  var viaCepRepositorio = ViaCepRepositorio();
  var atualizado = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [
              Text("Consulta CEP:", style: TextStyle(fontSize: 22)),
              TextField(
                controller: cepController,
                // maxLength: 8,
                keyboardType: TextInputType.number,
                onChanged: (value) async {
                  setState(() {
                    carregando = true;
                    cepB4a = B4aCepModelo([]);
                    atualizado = false;
                  });
                  // var cep = value.trim().replaceAll("-", "");
                  var cep = value.replaceAll(RegExp(r'[^0-9]'), "");
                  if (cep.length == 8) {
                    var consulta = await viaCepRepositorio.cosultaCEP(cep);
                    cepB4a = await viaCepRepositorio.buscarCEP(consulta.cep!);
                    if (cepB4a.results.isNotEmpty) {
                      var salvo = cepB4a.results[0].logradouro;
                      if (consulta.logradouro != salvo) {
                        cepB4a.results[0].cep = consulta.cep!;
                        cepB4a.results[0].logradouro = consulta.logradouro
                            .toString();
                        cepB4a.results[0].bairro = consulta.bairro.toString();
                        cepB4a.results[0].cidade = consulta.localidade
                            .toString();
                        cepB4a.results[0].uf = consulta.uf.toString();
                        await viaCepRepositorio.atualizar(cepB4a.results[0]);
                        atualizado = true;
                      }
                    }
                    if (cepB4a.results.isEmpty) {
                      viaCepModelo = await viaCepRepositorio.cosultaCEP(cep);
                      await viaCepRepositorio.salver(
                        CepB4aModelo.criar(
                          viaCepModelo.cep!,
                          viaCepModelo.logradouro!,
                          viaCepModelo.bairro!,
                          viaCepModelo.localidade!,
                          viaCepModelo.uf!,
                        ),
                      );
                    }
                  }
                  setState(() {
                    carregando = false;
                  });
                },
              ),
              SizedBox(height: 50),

              Visibility(
                visible: cepB4a.results.isNotEmpty,
                child: Column(
                  children: [
                    Text(
                      cepB4a.results.isEmpty
                          ? ""
                          : cepB4a.results[0].logradouro,
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      cepB4a.results.isEmpty ? "" : cepB4a.results[0].bairro,
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      "${cepB4a.results.isEmpty ? "" : cepB4a.results[0].cidade}- ${cepB4a.results.isEmpty ? "" : cepB4a.results[0].uf}",
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      atualizado ? "Foi Atualizado" : "",
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: cepB4a.results.isEmpty,
                child: Column(
                  children: [
                    Text(
                      viaCepModelo.logradouro ?? "",
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      viaCepModelo.bairro ?? "",
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      "${viaCepModelo.localidade ?? ""}- ${viaCepModelo.uf ?? ""}",
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: carregando,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Icon(Icons.home),
        ),
      ),
    );
  }
}
