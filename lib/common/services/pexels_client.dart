import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

class PexelsClient {
  PexelsClient._();
  factory PexelsClient() {
    log('KEHIT GK SIH');
    return _instance;
  }

  static final PexelsClient _instance = PexelsClient._();

  static final dio.Dio _dio = dio.Dio()
    ..options.connectTimeout = const Duration(seconds: 30)
    ..options.receiveTimeout = const Duration(seconds: 30);

  static String baseurl = 'https://api.pexels.com/v1';

  static Future<dio.Response> get({
    Map<String, dynamic>? data,
    String? url,
    Map<String, dynamic>? customHeader,
    String? path = '',
    bool showDebug = false,
  }) async {
    log('Url print :: ${(url ?? baseurl) + path!}');
    try {
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["Authorization"] = "lXQcQ9RFGtksG0dS34MeJoeveOAlULvT8aHGsrn6tDz7uzvkzELZGSIc";
      final res =
          await _dio.get((url ?? baseurl) + path, queryParameters: data);
      if (showDebug) {
        debugPrint('CALLING GET ${res.requestOptions.path}');
        debugPrint('Query GET ${res.requestOptions.queryParameters}');
        debugPrint('Data Response ${res.data}');
      }

      return res;
    } on dio.DioException catch (e) {
      print('DioException $e');
      _errorCatch(e);
      try {
        final Error error =
            ArgumentError('[500] Server Error, try again later');
        throw error;
      } catch (e) {
        final Error error = ArgumentError(e.toString());
        throw error;
      }
    } catch (e) {
      final Error error = ArgumentError('Something Went Wrong $e');
      throw error;
    }
  }

  static Future<dio.Response> post({
    Map<String, dynamic>? data,
    String? url,
    Map<String, dynamic>? customHeader,
    required String path,
    dio.FormData? form,
    // jsonMap for sending raw json to server
    Map<String, dynamic>? jsonMap,
    bool showDebug = false,
  }) async {
    try {
      final res =
          await _dio.post((url ?? baseurl) + path, data: form ?? jsonMap);

      if (showDebug) {
        debugPrint('CALLING GET ${res.requestOptions.path}');
        debugPrint('Query GET ${res.requestOptions.queryParameters}');
        debugPrint('Data Response ${res.data}');
        debugPrint('Data json: $jsonMap');
      }

      return res;
    } on dio.DioException catch (e) {
      _errorCatch(e);
      try {
        final Error error = ArgumentError(
          '[${e.response!.statusCode}] Server Error, try again later',
        );
        throw error;
      } catch (e) {
        final Error error = ArgumentError(e.toString());
        throw error;
      }
    } catch (e) {
      final Error error = ArgumentError('Something Went Wrong');
      throw error;
    }
  }

  static Future<dio.Response> put({
    Map<String, dynamic>? data,
    String? url,
    Map<String, dynamic>? customHeader,
    required String path,
    dio.FormData? form,
    // jsonMap for sending raw json to server
    Map<String, dynamic>? jsonMap,
  }) async {
    try {
      final res =
          await _dio.put((url ?? baseurl) + path, data: form ?? jsonMap);

      debugPrint('CALLING POST ${res.requestOptions.path}');
      // debugPrint("Response Data " + res.data.toString());

      return res;
    } on dio.DioException catch (e) {
      _errorCatch(e);
      try {
        final Error error = ArgumentError(
          '[${e.response!.statusCode}] Server Error, try again later',
        );
        throw error;
      } catch (e) {
        final Error error = ArgumentError(e.toString());
        throw error;
      }
    } catch (e) {
      final Error error = ArgumentError('Something Went Wrong');
      throw error;
    }
  }

  static void _errorCatch(dio.DioException e) {
    if (e.response != null) {
      debugPrint('Error CALLING ${e.requestOptions.path}');

      debugPrint('Error Status Code ${e.response!.statusCode}');
      debugPrint('Error Response ${e.response!.data}');
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      debugPrint('CALLING ${e.requestOptions.toString()}');
      inspect(e.requestOptions);
      print(e.message);
    }
  }
}
