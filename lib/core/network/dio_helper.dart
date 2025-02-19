import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'endpoints.dart';

/// A helper class for making HTTP requests using Dio.
class DioHelper {
  static late Dio dio;

  /// Initialize Dio with base options and add interceptors.
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE,PATCH,OPTIONS'
        },
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      error: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ),);
  }

  /// Makes a GET request to the specified URL.
  ///
  /// Parameters:
  /// - [url]: The URL to send the GET request to.
  /// - [queryParameters]: Optional query parameters.
  /// - [onReceiveProgress]: Callback to listen for the progress of receiving response.
  /// - [token]: Optional authorization token.
  ///
  /// Returns a [Future] with a [Response] object.
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
      };
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      // Handle any errors and rethrow them for higher-level error handling.
      rethrow;
    }
  }

  /// Makes a POST request with form data to the specified URL.
  ///
  /// Parameters:
  /// - [url]: The URL to send the POST request to.
  /// - [formData]: The form data to be sent in the request.
  /// - [token]: Optional authorization token.
  /// - [onSendProgress]: Callback to listen for the progress of sending request.
  /// - [onReceiveProgress]: Callback to listen for the progress of receiving response.
  ///
  /// Returns a [Future] with a [Response] object.
  static Future<Response> postFormData({
    required String url,
    required FormData formData,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        'Accept': 'application/json',
      };
      final Response response = await dio.post(
        url,
        data: formData,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Makes a POST request with JSON data to the specified URL.
  ///
  /// Parameters:
  /// - [url]: The URL to send the POST request to.
  /// - [data]: The JSON data to be sent in the request body.
  /// - [token]: Optional authorization token.
  /// - [onSendProgress]: Callback to listen for the progress of sending request.
  /// - [onReceiveProgress]: Callback to listen for the progress of receiving response.
  ///
  /// Returns a [Future] with a [Response] object.
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        'Accept': 'application/json',
      };
      final Response response = await dio.post(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Makes a PUT request to the specified URL.
  ///
  /// Parameters:
  /// - [url]: The URL to send the PUT request to.
  /// - [data]: The data to be sent in the request body.
  /// - [token]: Optional authorization token.
  /// - [onSendProgress]: Callback to listen for the progress of sending request.
  /// - [onReceiveProgress]: Callback to listen for the progress of receiving response.
  ///
  /// Returns a [Future] with a [Response] object.
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        'Accept': 'application/json',
      };
      final Response response = await dio.put(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Makes a PATCH request to the specified URL.
  ///
  /// Parameters:
  /// - [url]: The URL to send the PATCH request to.
  /// - [data]: The data to be sent in the request body.
  /// - [token]: The authorization token.
  ///
  /// Returns a [Future] with a [Response] object.
  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    required String token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final Response response = await dio.patch(
        url,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Makes a DELETE request to the specified URL.
  ///
  /// Parameters:
  /// - [url]: The URL to send the DELETE request to.
  /// - [data]: Optional data to be sent in the request body.
  /// - [token]: The authorization token.
  ///
  /// Returns a [Future] with a [Response] object.
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    required String token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      final Response response = await dio.delete(
        url,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}