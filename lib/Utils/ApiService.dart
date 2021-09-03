import 'package:dio/dio.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';

class ApiRequest {
  final String baseUrl = 'http://3.23.46.248:8000';
  Dio _dio() {
    // Put your authorization token here
    return Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
  }

  Future<Response> fetchData(RequestBody data) async {
    return await _dio().post('/fetch', data: data.toJson());
  }

  Future<Response> storeData(RequestBody data) async {
    return await _dio().post('/store', data: data.toJson());
  }

  Future<Response> loginUser(RequestBody data) async {
    return await _dio().post('/loginUser', data: data.toJson());
  }

  Future<Response> createUser(RequestBody data) async {
    return await _dio().post('/createUser', data: data.toJson());
  }
}
