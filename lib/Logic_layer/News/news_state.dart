part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<ArticleModel>? articleList;
  const NewsLoaded({required this.articleList});
}

class NewsError extends NewsState {
  final String? errorMessage;
  const NewsError({required this.errorMessage});
}
