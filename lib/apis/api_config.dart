import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:one_context/one_context.dart';

var storage = const FlutterSecureStorage();

enum RequestMethod { get, post, put, delete }

const String baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  // defaultValue: 'http://10.0.2.2:8080/api/',
  defaultValue: 'http://172.16.0.128:8080/api/',
);

typedef RequestBody = Map<String, dynamic>;
typedef ResponseBody = Map<String, dynamic>;
typedef ApiHeaderType = Map<String, String>;

abstract class ApiConfig {
  String path;
  RequestMethod method;
  bool isAuth;
  String module;

  ApiConfig({
    required this.path,
    required this.method,
    this.isAuth = true,
    required this.module,
  });

  String getUrlString({String? urlParam}) {
    return "$baseUrl$module$path${urlParam ?? ''}";
  }

  Future<dynamic> sendRequest(
      {String? urlParam, RequestBody? body, ApiHeaderType? headersCustom, String? token}) {
    return RequestHandler.call(getUrlString(urlParam: urlParam), method,
        authorized: isAuth, body: body, headersCustom: headersCustom, token: token);
  }
}

extension MethodManager on RequestMethod {
  Future<http.Response> apiCall(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    switch (this) {
      case RequestMethod.get:
        return await http.get(url, headers: headers);
      case RequestMethod.post:
        return await http.post(url, headers: headers, body: body);
      case RequestMethod.put:
        return await http.put(url, headers: headers, body: body);
      case RequestMethod.delete:
        return await http.delete(url, headers: headers, body: body);
    }
  }
}

class RequestHandler {
  static Future<dynamic> call(String urlString, RequestMethod method,
      {bool authorized = true,
      RequestBody? body,
      ApiHeaderType? headersCustom,
      String? token}) async {
    try {
      Map<String, String> headers = headersCustom ??
          {
            'Content-Type': 'application/json',
            if (authorized) 'Authorization': 'Bearer $token',
          };
      final response = await method.apiCall(Uri.parse(urlString),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        final dynamic result = json.decode(utf8.decode(response.bodyBytes))['data'];
        return result;
      } else if(json.decode(utf8.decode(response.bodyBytes))['message'] != null) {
        OneContext().showDialog(
            builder: (_) => AlertDialog(
                  title: const Text('Oops!', textAlign: TextAlign.center,),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/fail.png',
                        width: 120.0,
                        height: 120.0,
                        fit: BoxFit.cover,
                      ),
                      Text(json.decode(utf8.decode(response.bodyBytes))['message']),
                    ],
                  ),
                ));
        throw Exception(response.reasonPhrase);
      } else{
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print('There is an issue with : $urlString');
      throw Exception(e.toString());
    }
  }
}
