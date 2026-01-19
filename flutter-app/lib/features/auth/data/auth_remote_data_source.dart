import 'package:dio/dio.dart';
import 'package:synapseos_flutter/core/network/api_endpoints.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<String> login(String username, String password) async {
    final response = await dio.post(
      ApiEndpoints.login,
      data: {'username': username, 'password': password},
    );
    return response.data['token'];
  }

  Future<String> register(String username, String email, String password) async {
    final response = await dio.post(
      ApiEndpoints.register,
      data: {'username': username, 'email': email, 'password': password},
    );
    return response.data['token'];
  }
}
