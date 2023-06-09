import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';

class Http {
  BaseOptions options = BaseOptions(
    responseType:ResponseType.json,
    // baseUrl: 'https://gridtest.manager.jiuqi.com.cn/',
    connectTimeout: Duration(seconds: 90),
    receiveTimeout: Duration(seconds: 90),
    headers: {
       'Accept-Charset': 'utf-8',
       'Content-Type': 'application/json',
    }
  );

  late final Dio _dio;

  Http() {
    _dio = Dio(options);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print(options.baseUrl);
          // Do something before request is sent.
          // If you want to resolve the request with custom data,
          // you can resolve a `Response` using `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject with a `DioError` using `handler.reject(dioError)`.
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Do something with response data.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object using `handler.reject(dioError)`.
          return handler.next(response);
        },
        onError: (e, handler) {
          print(e.type);
          ErrorEntity eInfo = createErrorEntity(e);
          // onError(eInfo);
          print(eInfo);
          
          return handler.next(e); //continue
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          // return handler.next(e);
        },
      ),
    );
  }
// 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.unknown:
        return ErrorEntity(code: -1, message: "未知错误");
      case DioErrorType.connectionTimeout:
        return ErrorEntity(code: -1, message: "连接超时");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -1, message: "请求超时");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -1, message: "响应超时");
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: "请求取消");
      case DioErrorType.badCertificate:
        return ErrorEntity(code: -1, message: "证书错误");
      case DioErrorType.connectionError:
        return ErrorEntity(code: -1, message: "连接错误");
      case DioErrorType.badResponse:
        {
          try {
            int errCode =
                error.response != null ? error.response!.statusCode! : -1;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "请求语法错误");
              case 401:
                return ErrorEntity(code: errCode, message: "没有权限");
              case 403:
                return ErrorEntity(code: errCode, message: "服务器拒绝执行");
              case 404:
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              case 405:
                return ErrorEntity(code: errCode, message: "请求方法被禁止");
              case 500:
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              case 502:
                return ErrorEntity(code: errCode, message: "无效的请求");
              case 503:
                return ErrorEntity(code: errCode, message: "服务器挂了");
              case 505:
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return ErrorEntity(
                    code: errCode,
                    message: error.response != null
                        ? error.response!.statusMessage!
                        : "",
                  );
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "响应错误");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message??'');
        }
    }
  }

  Future get(String url, {Map<String, dynamic>? data}) async {
    final res = await _dio.get(url, queryParameters: data);
    return res.data;
  }

  Future post(String url, {Map<String, dynamic>? data}) async {
    final response = await _dio.post(url, data: data);
    return response.data;
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  ErrorEntity({required this.code, required this.message});

  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
