import 'dart:async';
import 'dart:convert';
import 'package:filmku/constants/api_keys/tmbd_api.dart';
import 'package:filmku/core/helpers/exceptions.dart';
import 'package:filmku/core/utilities/connectivity_manager.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class CacheableBaseClient {
  final String _baseUrl = TMDbApi.baseUrl;
  final String _apiKey = TMDbApi.apiKey;
  static const timeOutDuration = 10;

  Future<Map<String, dynamic>> get(String api) async {
    final url = '$_baseUrl$api&api_key=$_apiKey';
    var box = Hive.box('apiResponses');

    // print('!!!!! CONNECTIVITY RESULT' + connectivityResult.toString());
    if (!await ConnectivityManager.isConnectedToInternet()) {
      debugPrint('!!! Cache Hit');
      // Device is offline, fetch data from Hive
      var res = box.get(url);
      if (res != null) {
        return jsonDecode(res);
      }
    } else {
      // Device is online, fetch data from API and updating Hive
      debugPrint('!!!! Api Hit');
      try {
        final response = await http
            .get(Uri.parse(url))
            .timeout(const Duration(seconds: timeOutDuration));
        final data = _processResponse(response);

        // Update Hive with new data
        await box.put(url, jsonEncode(data));

        return data;
      } on TimeoutException {
        throw ApiNotRespondingException(
          message: 'API Not responded in $timeOutDuration Seconds',
          url: url.toString(),
        );
      }
    }
    return {};
  }

  dynamic _processResponse(
      http.Response response,
      ) {
    switch (response.statusCode) {
      case 200:
        final responseJson = utf8.decode(response.bodyBytes);
        return jsonDecode(responseJson);
      case 400:
        throw BadRequestException(
          message: utf8.decode(response.bodyBytes),
          url: response.request?.url.toString(),
        );
      case 403:
        throw UnAuthorizedException(
          message: utf8.decode(response.bodyBytes),
          url: response.request?.url.toString(),
        );
      default:
        throw FetchDataException(
          message: 'Error occurred with this ${response.statusCode}',
          url: response.request?.url.toString(),
        );
    }
  }
}
