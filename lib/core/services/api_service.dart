import 'package:dio/dio.dart';
// import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:Nexus/core/utils/app_logger.dart';
// ignore: library_prefixes

class ApiService {
  final Dio _dio;

  // Declare a CancelToken instance
  late CancelToken _cancelToken;

  ApiService() : _dio = Dio() {
    _dio.options.baseUrl = "http://192.168.201.1:5001/v1/";
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    // Initialize the cancel token
    _cancelToken = CancelToken();

    // _dio.interceptors.add(RetryInterceptor(
    //   dio: _dio,
    //   logPrint: appLog, // specify log function (optional)
    //   retries: 3, // retry count (optional)
    //   retryDelays: const [
    //     // set delays between retries (optional)
    //     Duration(seconds: 1), // wait 1 sec before first retry
    //     Duration(seconds: 2), // wait 2 sec before second retry
    //     Duration(seconds: 3), // wait 3 sec before third retry
    //   ],
    // ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add the access token to the request header
          var token = await FirebaseAuth.instance.currentUser?.getIdToken();
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // if (e.response?.statusCode == 401) {
          //   // If a 401 response is received, refresh the access token
          //   String newAccessToken = await refreshToken();

          //   // Update the request header with the new access token
          //   e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          //   // Repeat the request with the updated header
          //   return handler.resolve(await dio.fetch(e.requestOptions));
          // }
          return handler.next(e);
        },
      ),
    );
  }

  // Function to cancel requests using the cancel token
  void cancelRequests({String? reason}) {
    _cancelToken.cancel(reason);
    _cancelToken = CancelToken(); // Reinitialize the cancel token
  }

  static String? token;
  static Future<String> getToken() async {
    // Retrieve the user's token from FirebaseAuth if the user is logged in

    token = await FirebaseAuth.instance.currentUser?.getIdToken();

    if (kDebugMode) {
      await Clipboard.setData(ClipboardData(text: token ?? ''));
    }

    appLog(token, 'APISERVICE.token from splash');

    return token ?? '';
  }

  Future<void> get(
    String path, {
    Map<String, dynamic>? params,
    required Function(Response<dynamic>? data) onSuccess,
    required Function(Response<dynamic>? error) onError,
    Map<String, dynamic>? data,
    // String? token,
  }) async {
    try {
      String authToken = token ?? '';
      final response = await _dio.get(
        path,
        data: data,
        queryParameters: params,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $authToken",
          },
        ),
      );
      onSuccess(response);
    } on DioException catch (error) {
      appLog(error, 'Failed');
      // UiService().showErrorSnackBar(message: "Failed to fetch rate. Please try again.");

      onError(error.response);
    }
  }

  Future<void> post(
    String path, {
    Map<String, dynamic>? data,
    required Function(Response<dynamic>? data) onSuccess,
    required Function(Response<dynamic>? error) onError,
    Function(dynamic dioerror)? onDioError,
    // String? token,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     "Authorization": "Bearer $token",
        //   },
        // ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess(response);
      } else {
        appLog(response, 'not 200');
        onError(response);
      }
    } on DioException catch (error) {
      appLog(error, 'Failed');
      onError(error.response);
    }
  }

  Future<void> patch(
    String path, {
    Map<String, dynamic>? data,
    required Function(Response<dynamic>? data) onSuccess,
    required Function(Response<dynamic>? error) onError,
    Function(dynamic dioerror)? onDioError,
    // String? token,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );
      appLog(response.statusCode, "response.statusCode");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        onSuccess(response);
      } else {
        appLog(response, 'not 200');
        onError(response);
      }
    } on DioException catch (error) {
      appLog(error, 'Failed');
      onError(error.response);
    }
  }

  Future<void> getUserInfo(
    int userId, {
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    final path = '/users/$userId';
    return get(path, onSuccess: onSuccess, onError: onError);
  }

  Future<void> postFormData(String path,
      {required FormData data,
      required Function(Response<dynamic>? data) onSuccess,
      required Function(Response<dynamic>? error) onError,
      Function(dynamic dioerror)? onDioError,
      String? token}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            'Content-Type':
                'multipart/form-data; boundary=<calculated when request is sent>',
            "Authorization": "Bearer $token",
          },
        ),
      );
      appLog(response, 'success');
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess(response);
      } else {
        appLog(response, 'not 200');
        onError(response);
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        return;
      }
      if (error.type == DioExceptionType.connectionError) {
        return;
      }
      appLog(error.type, 'Failed');
      onError(error.response);
    }
  }
}
