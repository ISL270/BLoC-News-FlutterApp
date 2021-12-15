import 'package:bloc/bloc.dart';
import 'package:bloc_news/Data_layer/repositories/news_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_news/Data_layer/models/article_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepository? newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<NewsRequested>((event, emit) async {
      emit(NewsLoading());
      List<ArticleModel> _articleList = [];
      try {
        _articleList = await newsRepository!.fetchNews();
        emit(NewsLoaded(articleList: _articleList));
      } catch (e) {
        emit(NewsError(errorMessage: e.toString()));
      }
    });
  }
}
