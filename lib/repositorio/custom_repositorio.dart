import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomRepositorio {
  final _dio = Dio();
  Dio get dio => _dio;
  CustomRepositorio() {
    _dio.options.headers["X-Parse-Application-Id"] = dotenv.get(
      "XPARSEAPPLICATIONID",
    );
    _dio.options.headers["X-Parse-REST-API-Key"] = dotenv.get(
      "XPERSERESTAPIKEY",
    );
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("URLBASE");
  }
}
