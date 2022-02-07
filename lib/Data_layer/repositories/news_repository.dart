import 'dart:convert';
import 'dart:io';
import 'package:bloc_news/Services/globals.dart';
import 'package:bloc_news/Services/news_api.dart';
import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  final API api;
  NewsRepository(this.api);

  Future<List<ArticleModel>> fetchNews() async {
    final uri = api.endpointUri();
    List<ArticleModel> _articleModelList = [];
    try {
      var response = await http.get(uri);
      var data = jsonDecode(response.body);

      for (var item in data["articles"]) {
        ArticleModel _articleModel = ArticleModel.fromJson(item);
        _articleModelList.add(_articleModel);
      }
    } on SocketException {
      snackbarKey.currentState
          ?.showSnackBar(SnackBar(content: Text("No Internet connection!")));
    } on HttpException {
      snackbarKey.currentState?.showSnackBar(
          SnackBar(content: Text("Couldn't find the requested data!")));
    } on FormatException {
      snackbarKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Bad response format!")));
    }
    return _articleModelList;
  }
}
