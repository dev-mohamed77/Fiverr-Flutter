import 'package:dio/dio.dart';
import 'package:fiverr/core/service/network_service/api_intercepters.dart';
import 'package:fiverr/core/service/network_service/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DioNetWorkService extends NetWorkService {
  Future<Response> downloadData(
    String path, {
    required dynamic savePath,
    void Function(int, int)? onReceiveProgress,
    CancelToken? cancelToken,
  });
}

class DioService implements DioNetWorkService {
  late Dio _dio;
  final Ref ref;

  DioService._({required this.ref}) {
    const localUrl = 'http://192.168.1.6:3000/api/';

    _dio = ref.watch(dioProvider.call(localUrl));

    _dio.interceptors.add(
      AuthInterceptor(ref: ref),
    );
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      error: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  factory DioService({required Ref ref}) => DioService._(ref: ref);

  @override
  Future<Response> postData(String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? data,
      bool isFormData = false,
      String? token}) {
    return _dio.post(
      path,
      data: isFormData ? FormData.fromMap(data!) : data,
      queryParameters: queryParams,
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
  }

  @override
  Future<Response> getData(String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? data,
      bool isFormData = false,
      String? token}) {
    return _dio.get(
      path,
      queryParameters: queryParams,
      data: isFormData ? FormData.fromMap(data!) : data,
      options: Options(
        headers: {"Authorization": token},
      ),
    );
  }

  @override
  Future<Response> updateData(String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? data,
      bool isFormData = false,
      String? token}) {
    return _dio.put(
      path,
      queryParameters: queryParams,
      data: isFormData ? FormData.fromMap(data!) : data,
      options: Options(
        headers: {"Authorization": token},
      ),
    );
  }

  @override
  Future<Response> deleteData(String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? data,
      bool isFormData = false,
      String? token}) {
    return _dio.delete(
      path,
      queryParameters: queryParams,
      data: isFormData ? FormData.fromMap(data!) : data,
      options: Options(
        headers: {"Authorization": token},
      ),
    );
  }

  @override
  Future<Response> downloadData(
    String path, {
    required savePath,
    void Function(int p1, int p2)? onReceiveProgress,
    CancelToken? cancelToken,
  }) {
    return _dio.download(
      path,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      deleteOnError: true,
    );
  }
}

final dioServiceProvider = Provider(
  (ref) => DioService(ref: ref),
);

final dioProvider = Provider.family(
  (ref, String url) => Dio(
    BaseOptions(
      baseUrl: url,
      receiveDataWhenStatusError: true,
      sendTimeout: const Duration(seconds: 15),
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      followRedirects: false,
    ),
  ),
);
