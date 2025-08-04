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
  var carregando = false;
  var viaCepModelo = ViaCepModelo();
  var viaCepRepositorio = ViaCepRepositorio();
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
                  });
                  // var cep = value.trim().replaceAll("-", "");
                  var cep = value.replaceAll(RegExp(r'[^0-9]'), "");
                  if (cep.length == 8) {
                    viaCepModelo = await viaCepRepositorio.cosultaCEP(cep);
                  }
                  setState(() {
                    carregando = false;
                  });
                },
              ),
              SizedBox(height: 50),
              Text(
                viaCepModelo.logradouro ?? "",
                style: TextStyle(fontSize: 22),
              ),
              Text(viaCepModelo.bairro ?? "", style: TextStyle(fontSize: 22)),
              Text(
                "${viaCepModelo.localidade ?? ""}- ${viaCepModelo.uf ?? ""}",
                style: TextStyle(fontSize: 22),
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
