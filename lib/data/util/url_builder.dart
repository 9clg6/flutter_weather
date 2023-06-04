import 'package:flutter_weather/domain/exception/url_params_exception.dart';

String buildUrlWithParams(String baseUrl, Map<String, dynamic>? params) {
  if (params == null || params.isEmpty) {
    throw UrlParamsException("Les paramètres donnés sont null ou vides");
  }

  for (int i = 0; i < params.entries.length; i++) {
    final currentEntry = params.entries.elementAt(i);
    baseUrl += "${i == 0 ? "?" : "&"}${currentEntry.key}=${currentEntry.value}";
  }

  return baseUrl;
}
