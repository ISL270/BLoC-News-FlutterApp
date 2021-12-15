import 'dart:convert';
import 'package:bloc_news/Services/news_api.dart';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  final API api;
  NewsRepository(this.api);

  Future<List<ArticleModel>> fetchNews() async {
    final uri = api.endpointUri();
    var response = await http.get(uri);

    var data = jsonDecode(response.body);

    List<ArticleModel> _articleModelList = [];

    if (response.statusCode == 200) {
      for (var item in data["articles"]) {
        ArticleModel _articleModel = ArticleModel.fromJson(item);
        _articleModelList.add(_articleModel);
      }
      return _articleModelList;
    } else {
      return _articleModelList;
    }
  }
}
