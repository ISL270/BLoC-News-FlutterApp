import 'dart:convert';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<List<ArticleModel>> fetchNews() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2021-12-14&sortBy=publishedAt&apiKey=eee5df5dfc9844618cee1166940e9115"));

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
