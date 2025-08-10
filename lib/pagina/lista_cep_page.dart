import 'package:consulta_cep/modelo/b4a_cep_modelo.dart';
import 'package:consulta_cep/repositorio/via_cep_repositorio.dart';
import 'package:flutter/material.dart';

class ListaCepPage extends StatefulWidget {
  const ListaCepPage({super.key});

  @override
  State<ListaCepPage> createState() => _ListaCepPageState();
}

class _ListaCepPageState extends State<ListaCepPage> {
  ViaCepRepositorio viaCepRepositorio = ViaCepRepositorio();
  var lista_cep = B4aCepModelo([]);

  @override
  void initState() {
    super.initState();
    carregarListaDeCeps();
  }

  void carregarListaDeCeps() async {
    lista_cep = await viaCepRepositorio.b4aListaCEP();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de CEPs')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: Icon(Icons.home),
      ),
      body: lista_cep.results.isEmpty
          ? Center(child: Text("Ainta não tem CEP pesquisado!"))
          : ListView.builder(
              itemCount: lista_cep.results.length,
              itemBuilder: (BuildContext bc, int index) {
                var ceps = lista_cep.results[index];
                return Dismissible(
                  onDismissed: (DismissDirection dismissDirection) async {
                    await viaCepRepositorio.remover(ceps.objectId);
                    carregarListaDeCeps();
                  },
                  key: Key(ceps.cep),
                  child: Card(
                    child: ListTile(
                      title: Text(ceps.logradouro),
                      subtitle: Text("""
            Bairro: ${ceps.bairro} CEP: ${ceps.cep}
            Cidade-UF: ${ceps.cidade} - ${ceps.uf}
            """),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
