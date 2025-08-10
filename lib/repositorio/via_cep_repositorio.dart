import 'dart:convert';

import 'package:consulta_cep/modelo/b4a_cep_modelo.dart';
import 'package:consulta_cep/modelo/via_cep_modelo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ViaCepRepositorio {
  var _dio = Dio();
  ViaCepRepositorio() {
    _dio = Dio();
    _dio.options.headers["X-Parse-Application-Id"] = dotenv.get(
      "XPARSEAPPLICATIONID",
    );
    _dio.options.headers["X-Parse-REST-API-Key"] = dotenv.get(
      "XPERSERESTAPIKEY",
    );
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("URLBASE");
  }

  Future<ViaCepModelo> cosultaCEP(String cep) async {
    var resposta = await http.get(
      Uri.parse("https://viacep.com.br/ws/$cep/json/"),
    );
    if (resposta.statusCode == 200) {
      var dado = jsonDecode(resposta.body);
      return ViaCepModelo.fromJson(dado);
    }
    return ViaCepModelo();
  }

  Future<B4aCepModelo> b4aListaCEP() async {
    var url = "/lista_cep";

    var resposta = await _dio.get(url);

    if (resposta.statusCode == 200) {
      return B4aCepModelo.fromJson(resposta.data);
    } else {
      return B4aCepModelo([]);
    }
  }

  Future<B4aCepModelo> buscarCEP(String cep) async {
    var url = "/lista_cep";
    url = "$url?where={\"cep\":\"$cep\"}";

    var resposta = await _dio.get(url);

    if (resposta.statusCode == 200) {
      return B4aCepModelo.fromJson(resposta.data);
    } else {
      return B4aCepModelo([]);
    }
  }

  Future<void> salver(CepB4aModelo cepB4aModelo) async {
    await _dio.post("/lista_cep", data: cepB4aModelo.toJsonEndpoint());
  }

  Future<void> atualizar(CepB4aModelo cepB4aModelo) async {
    await _dio.put(
      "/lista_cep/${cepB4aModelo.objectId}",
      data: cepB4aModelo.toJsonEndpoint(),
    );
  }

  Future<void> remover(String objectId) async {
    await _dio.delete("/lista_cep/$objectId");
  }
}
