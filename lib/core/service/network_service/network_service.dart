import 'package:dio/dio.dart';

abstract class NetWorkService {
  Future<Response> postData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    String? token,
  });
  Future<Response> getData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    String? token,
  });
  Future<Response> updateData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    String? token,
  });
  Future<Response> deleteData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    String? token,
  });
}
