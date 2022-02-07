import 'package:bloc_news/Logic_layer/News/news_bloc.dart';
import 'package:bloc_news/Data_layer/repositories/news_repository.dart';
import 'package:bloc_news/Presentation_layer/home_screen.dart';
import 'package:bloc_news/Services/news_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Services/globals.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsBloc>(
      create: (context) =>
          NewsBloc(newsRepository: NewsRepository(API.sandbox()))
            ..add(NewsRequested()),
      child: MaterialApp(
        scaffoldMessengerKey: snackbarKey,
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
