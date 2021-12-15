import 'package:bloc_news/Services/api_keys.dart';
import 'package:flutter/foundation.dart';

class API {
  final String? apiKey;
  API({@required this.apiKey});

  factory API.sandbox() => API(apiKey: APIkeys.newsKey);

  static const String host = "newsapi.org";

  static const String path = "v2/top-headlines";

  static const String query = "country=us&category=business&apiKey=";

  Map<String, String> addApiKey(String apiKey) => <String, String>{
        "country": "us",
        "category": "business",
        "apiKey": apiKey
      };

  Uri endpointUri() => Uri(
      scheme: 'https',
      host: host,
      path: path,
      queryParameters: addApiKey(apiKey!));
}
