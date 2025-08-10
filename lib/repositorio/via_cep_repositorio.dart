import 'package:consulta_cep/modelo/b4a_cep_modelo.dart';
import 'package:consulta_cep/modelo/via_cep_modelo.dart';
import 'package:consulta_cep/repositorio/custom_repositorio.dart';

class ViaCepRepositorio {
  final _dio = CustomRepositorio();
  ViaCepRepositorio();

  Future<ViaCepModelo> cosultaCEP(String cep) async {
    var resposta = await _dio.dio.get("https://viacep.com.br/ws/$cep/json/");
    if (resposta.statusCode == 200) {
      return ViaCepModelo.fromJson(resposta.data);
    }
    return ViaCepModelo();
  }

  Future<B4aCepModelo> b4aListaCEP() async {
    var url = "/lista_cep";

    var resposta = await _dio.dio.get(url);

    if (resposta.statusCode == 200) {
      return B4aCepModelo.fromJson(resposta.data);
    } else {
      return B4aCepModelo([]);
    }
  }

  Future<B4aCepModelo> buscarCEP(String cep) async {
    var url = "/lista_cep";
    url = "$url?where={\"cep\":\"$cep\"}";

    var resposta = await _dio.dio.get(url);

    if (resposta.statusCode == 200) {
      return B4aCepModelo.fromJson(resposta.data);
    } else {
      return B4aCepModelo([]);
    }
  }

  Future<void> salver(CepB4aModelo cepB4aModelo) async {
    await _dio.dio.post("/lista_cep", data: cepB4aModelo.toJsonEndpoint());
  }

  Future<void> atualizar(CepB4aModelo cepB4aModelo) async {
    await _dio.dio.put(
      "/lista_cep/${cepB4aModelo.objectId}",
      data: cepB4aModelo.toJsonEndpoint(),
    );
  }

  Future<void> remover(String objectId) async {
    await _dio.dio.delete("/lista_cep/$objectId");
  }
}
