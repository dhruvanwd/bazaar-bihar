import 'package:dio/dio.dart';
import 'package:bazaar_bihar/Utils/RequestBody.dart';

class ApiRequest {
  final String baseUrl;

  ApiRequest({
    required this.baseUrl,
  });

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
