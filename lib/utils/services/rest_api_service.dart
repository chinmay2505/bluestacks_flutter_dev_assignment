import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

enum RestAPIRequestMethods { GET, PUT, POST, DELETE, PATCH }

/// Singleton class
class RestAPIService {
  static RestAPIService? _instance;

  RestAPIService._internal();

  static RestAPIService? getInstance() {
    if (_instance == null) {
      _instance = RestAPIService._internal();
    }

    return _instance;
  }

  Future<dynamic> requestCall(
      {required String apiEndPoint,
      required RestAPIRequestMethods method,
      dynamic requestParmas}) async {
    String _apiEndPoint = apiEndPoint;

    Map<String, String> _httpHeaders = {
      HttpHeaders.contentTypeHeader: "application/json"
    };

    /// make the complete URL of API
    Uri _apiUrl = Uri.parse('$_apiEndPoint');

    /// json encode the request params
    dynamic _requestParmas = json.encode(requestParmas);

    var responseJson;

    switch (method) {
      case RestAPIRequestMethods.GET:
        try {
          final response = await http.get(_apiUrl, headers: _httpHeaders);
          responseJson = _returnResponse(response);
        } on SocketException {
          throw FetchDataException(0000,
              'No internet connection found, Please check your internet and try again!');
        } on FormatException {
          throw BadRequestException(0001,
              'Unable to process your request due to some failure, Please try again later!');
        } on http.ClientException {
          throw FetchDataException(0002,
              'Oh No! Unable to process your request. Possible cases may be server is not reachable or if server runs on VPN then VPN should be connected on mobile device!');
        }
        break;
      case RestAPIRequestMethods.POST:
        try {
          final response = await http.post(_apiUrl,
              body: _requestParmas, headers: _httpHeaders);
          responseJson = _returnResponse(response);
        } on SocketException {
          throw FetchDataException(0000,
              'No internet connection found, Please check your internet and try again!');
        } on FormatException {
          throw BadRequestException(0001,
              'Unable to process your request due to some failure, Please try again later!');
        } on http.ClientException {
          throw FetchDataException(0002,
              'Oh No! Unable to process your request. Possible cases may be server is not reachable or if server runs on VPN then VPN should be connected on mobile device!');
        }
        break;
      case RestAPIRequestMethods.PUT:
        try {
          final response = await http.put(_apiUrl,
              body: _requestParmas, headers: _httpHeaders);
          responseJson = _returnResponse(response);
        } on SocketException {
          throw FetchDataException(0000,
              'No internet connection found, Please check your internet and try again!');
        } on FormatException {
          throw BadRequestException(0001,
              'Unable to process your request due to some failure, Please try again later!');
        } on http.ClientException {
          throw FetchDataException(0002,
              'Oh No! Unable to process your request. Possible cases may be server is not reachable or if server runs on VPN then VPN should be connected on mobile device!');
        }
        break;
      case RestAPIRequestMethods.DELETE:
        try {
          /// normal delete request without body
          if (requestParmas == null) {
            final response = await http.delete(_apiUrl, headers: _httpHeaders);
            responseJson = _returnResponse(response);
          } else {
            /// delete request with body
            final request = http.Request("DELETE", _apiUrl);
            request.headers.addAll(_httpHeaders);
            request.body = json.encode(requestParmas);
            final streamedResponse = await request.send();
            final response = await http.Response.fromStream(streamedResponse);
            responseJson = _returnResponse(response);
          }
        } on SocketException {
          throw FetchDataException(0000,
              'No internet connection found, Please check your internet and try again!');
        } on FormatException {
          throw BadRequestException(0001,
              'Unable to process your request due to some failure, Please try again later!');
        } on http.ClientException {
          throw FetchDataException(0002,
              'Oh No! Unable to process your request. Possible cases may be server is not reachable or if server runs on VPN then VPN should be connected on mobile device!');
        }
        break;
      case RestAPIRequestMethods.PATCH:
        try {
          final response = await http.patch(_apiUrl,
              body: _requestParmas, headers: _httpHeaders);
          responseJson = _returnResponse(response);
        } on SocketException {
          throw FetchDataException(0000,
              'No internet connection found, Please check your internet and try again!');
        } on FormatException {
          throw BadRequestException(0001,
              'Unable to process your request due to some failure, Please try again later!');
        } on http.ClientException {
          throw FetchDataException(0002,
              'Oh No! Unable to process your request. Possible cases may be server is not reachable or if server runs on VPN then VPN should be connected on mobile device!');
        }
        break;
      default:
        break;
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    Map<String, dynamic> _responseBody = _getResponseBody(response);

    switch (response.statusCode) {
      case 200:
      case 201:
        var returnJson = _responseBody['data'] ?? _responseBody;
        return returnJson;
      case 204:
        Map<String, bool> _returnMap = {'success': true};
        return _returnMap;
      case 400:
        throw BadRequestException(
            _responseBody['error']['code'], _responseBody['error']['message']);
      case 401:

      /// Handle unauthentication
      case 403:
        throw UnAuthorisedException(
            _responseBody['error']['code'], _responseBody['error']['message']);
      default:
        throw BadRequestException(
            _responseBody['error']['code'], _responseBody['error']['message']);
    }
  }

  Map<String, dynamic> _getResponseBody(http.Response response) {
    Map<String, dynamic> _responseBody = {};
    if (response.body.isNotEmpty) {
      /// decode the response
      var _jsonResponse = json.decode(response.body);
      _responseBody = _jsonResponse;
    } else {
      _responseBody = {
        'error': {'code': 1111, 'message': 'Unexpected error'}
      };
    }
    return _responseBody;
  }
}

class RestAPICallException implements Exception {
  final int _errorCode;
  final String _message;

  RestAPICallException(this._errorCode, this._message);

  String toString() {
    return '$_errorCode:::$_message';
  }
}

class FetchDataException extends RestAPICallException {
  FetchDataException(int errorCode, String message) : super(errorCode, message);
}

class BadRequestException extends RestAPICallException {
  BadRequestException(int errorCode, String message)
      : super(errorCode, message);
}

class UnAuthenticationException extends RestAPICallException {
  UnAuthenticationException(int errorCode, String message)
      : super(errorCode, message);
}

class UnAuthorisedException extends RestAPICallException {
  UnAuthorisedException(int errorCode, String message)
      : super(errorCode, message);
}
