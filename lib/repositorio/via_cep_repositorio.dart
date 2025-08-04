import 'dart:convert';

import 'package:consulta_cep/modelo/b4a_cep_modelo.dart';
import 'package:consulta_cep/modelo/via_cep_modelo.dart';
import 'package:http/http.dart' as http;

class ViaCepRepositorio {

  Future<ViaCepModelo> cosultaCEP(String cep) async {
    print("consulta b4a");
    var resposta = await http.get(
      Uri.parse("https://viacep.com.br/ws/$cep/json/"),
    );
    if (resposta.statusCode == 200) {
      var dado = jsonDecode(resposta.body);
      return ViaCepModelo.fromJson(dado);
    }
    return ViaCepModelo();
  }

  Future<B4aCepModelo>b4abuscaCEP(String cep)async{
    
  }

}
