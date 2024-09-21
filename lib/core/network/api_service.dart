import 'package:dio/dio.dart';
import 'package:elevechurch/core/error/exeptions.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio}) {
    dio.options.baseUrl = 'https://api.elevatechurch.com.br/';
    dio.options.headers["Authorization"] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjY1OTE4MSwicm9sZSI6ImlncmVqYSIsImNodXJjaCI6eyJpZCI6NjU5MTgxLCJuYW1lIjoiQXNzZW1ibGVpYSBkZSBEZXVzIC0gTWFkdXJlaXJhIiwiZW1haWwiOiJhZG1AZ21haWwuY29tIiwibG9nbyI6bnVsbCwicGFyZW50Q2h1cmNoIjpudWxsfSwiaWF0IjoxNzE2MjE0OTY2fQ.zgKexaio7decQnFnLbsLDjWGIWf6vmOWbqrk8KlKJYM';
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(endpoint, queryParameters: params);
      return response.data;
    } on DioException catch (e) {
      throw ServerException(
          message: e.response?.data['message'] ?? 'Erro de servidor');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint,
      {dynamic data, Map<String, dynamic>? params}) async {
    try {
      final response =
          await dio.post(endpoint, data: data, queryParameters: params);
      return response.data;
    } on DioException catch (e) {
      print(e.response?.data);
      throw ServerException(
          message: e.response?.data['message'] ??
              e.response?.data['error'] ??
              'Erro de servidor');
    }
  }

  Future<Map<String, dynamic>> put(String endpoint,
      {dynamic data, Map<String, dynamic>? params}) async {
    try {
      final response =
          await dio.put(endpoint, data: data, queryParameters: params);
      return response.data;
    } on DioException catch (e) {
      throw ServerException(
          message: e.response?.data['message'] ?? 'Erro de servidor');
    }
  }

  Future<Map<String, dynamic>> patch(String endpoint,
      {dynamic data, Map<String, dynamic>? params}) async {
    try {
      final response =
          await dio.patch(endpoint, data: data, queryParameters: params);
      return response.data;
    } on DioException catch (e) {
      throw ServerException(
          message: e.response?.data['message'] ?? 'Erro de servidor');
    }
  }

  Future<void> delete(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      await dio.delete(endpoint, queryParameters: params);
    } on DioException catch (e) {
      throw ServerException(
          message: e.response?.data['message'] ?? 'Erro de servidor');
    }
  }
}
