class B4aCepModelo {
  List<CepB4aModelo> results = [];

  B4aCepModelo(this.results);

  B4aCepModelo.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <CepB4aModelo>[];
      json['results'].forEach((v) {
        results.add(CepB4aModelo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class CepB4aModelo {
  String objectId = "";
  String cep = "";
  String logradouro = "";
  String bairro = "";
  String cidade = "";
  String uf = "";
  String createdAt = "";
  String updatedAt = "";

  CepB4aModelo(
    this.objectId,
    this.cep,
    this.logradouro,
    this.bairro,
    this.cidade,
    this.uf,
    this.createdAt,
    this.updatedAt,
  );
  CepB4aModelo.criar(
    this.cep,
    this.logradouro,
    this.bairro,
    this.cidade,
    this.uf,
  );

  CepB4aModelo.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    uf = json['uf'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['cidade'] = cidade;
    data['uf'] = uf;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['cidade'] = cidade;
    data['uf'] = uf;
    return data;
  }
}
