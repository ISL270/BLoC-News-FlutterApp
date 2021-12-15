import 'package:bloc_news/Logic_layer/News/news_bloc.dart';
import 'package:bloc_news/Data_layer/repositories/news_repository.dart';
import 'package:bloc_news/Presentation_layer/home_screen.dart';
import 'package:bloc_news/Services/news_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NewsBloc>(
            create: (context) =>
                NewsBloc(newsRepository: NewsRepository(API.sandbox()))
                  ..add(NewsRequested()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ));
  }
}
