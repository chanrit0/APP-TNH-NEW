import 'dart:async';
import 'dart:convert';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/helper/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:app_tnh2/config/keyStorages.dart';


typedef RequestCallBack = void Function(Map data);

class HttpRequest {
  // BuildContext context;
  String baseUrl;
  String? accessToken;
  final Dio api = Dio();
  int countd = 0;

  HttpRequest(this.baseUrl) {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('http')) {
        options.path = baseUrl + options.path;
      }
      accessToken = await accessTokenStore(key: KeyStorages.accessToken);
      // print(accessToken);
      options.headers['Authorization'] = accessToken;
      options.headers['Accept'] = 'application/json';
      options.headers['Content-Type'] = 'application/json';
      options.sendTimeout = const Duration(seconds: 30);
      options.receiveTimeout = const Duration(seconds: 30);
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if (error.response?.statusCode == 401) {
        //error.response?.data['message'] == "Refresh Token Expired."
        if ((error.response?.data['message'] == "Token Expired.")) {
          if (await accessTokenStore(key: KeyStorages.refreshToken) != null) {
            if (await refreshToken()) {
              return handler.resolve(await _retry(error.requestOptions));
            }
          }
        } else {
          await accessTokenStore(
              key: KeyStorages.accessToken, action: "remove");
          await accessTokenStore(
              key: KeyStorages.refreshToken, action: "remove");
          await accessTokenStore(
              key: KeyStorages.signInStatus, action: "remove");
        }
      }
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    countd = countd + 1;
    if (countd == 1) {
      final refreshToken =
          await accessTokenStore(key: KeyStorages.refreshToken);
      final response = await api
          .post('/refresh_token', data: {'refresh_token': refreshToken});

      if (response.statusCode == 200) {
        await accessTokenStore(
            key: KeyStorages.accessToken,
            action: "set",
            value:
                '${response.data['token_type']} ${response.data['access_token']}');
        await accessTokenStore(
            key: KeyStorages.refreshToken,
            action: "set",
            value: response.data['refresh_token']);
        countd = countd - 1;
        return true;
      } else {
        await accessTokenStore(key: KeyStorages.accessToken, action: "remove");
        await accessTokenStore(key: KeyStorages.refreshToken, action: "remove");
        await accessTokenStore(key: KeyStorages.signInStatus, action: "remove");
        countd = countd - 1;
        return false;
      }
    } else {
      countd = countd - 1;
      return false;
    }
  }

  Future<dynamic> postDio(String uri, dynamic body) async {
    try {
      final response = await api.post(baseUrl + uri, data: body);
      return jsonEncode(response.data);
    } on DioError catch (e) {
      handleResponseError(e.response, uri, e);
    }
  }

  Future<dynamic> getDio(String uri) async {
    try {
      final response = await api.get(baseUrl + uri);
      return jsonEncode(response.data);
    } on DioError catch (e) {
      handleResponseError(e.response, uri, e);
    }
  }

  dynamic handleResponseError(
      Response<dynamic>? response, String url, DioError e) {
    switch (e.type) {
      case DioErrorType.cancel:
        throw ApiNotRespondingException(
            "Request to API server was cancelled", url);

      case DioErrorType.connectionTimeout:
        throw ApiNotRespondingException(
            "Connection timeout with API server", url);

      case DioErrorType.receiveTimeout:
        throw ApiNotRespondingException(
            "Receive timeout in connection with API server", url);

      case DioErrorType.badResponse:
        _handleError(e.response?.statusCode, e.response?.data, url);
        break;
      case DioErrorType.sendTimeout:
        throw ApiNotRespondingException(
            "Send timeout in connection with API server", url);

      case DioErrorType.unknown:
        throw NoInternerConnection('No Internet connection', url);

      default:
        throw FetchDataException("Something went wrong", url);
    }
  }

  _handleError(int? statusCode, dynamic error, String url) {
    switch (statusCode) {
      case 400:
        throw BadRequestException(error['message'], url);
      case 401:
        if (error['message'] != "Token Expired.") {
          throw UniAuthorizedException(error['message'], url);
        } else {
          break;
        }
      case 403:
        throw UniAuthorizedException(error['message'], url);
      case 404:
        throw BadRequestException(error['message'], url);
      case 500:
        throw FetchDataException('Internal server error', url);
      case 502:
        throw FetchDataException('Bad gateway', url);
      default:
        throw FetchDataException('Oops something went wrong', url);
    }
  }
}
