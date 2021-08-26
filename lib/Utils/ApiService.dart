import 'package:dio/dio.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';

class ApiRequest {
  final String baseUrl = 'http://52.14.49.133:8000';
  Dio _dio() {
    // Put your authorization token here
    return Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
  }

  fetchData(RequestBody data) async {
    return await _dio().post('/fetch', data: data.toJson());
  }

  storeData(RequestBody data) async {
    return await _dio().post('/store', data: data.toJson());
  }

  loginUser(RequestBody data) async {
    return await _dio().post('/loginUser', data: data.toJson());
  }

  createUser(RequestBody data) async {
    return await _dio().post('/createUser', data: data.toJson());
  }
}
