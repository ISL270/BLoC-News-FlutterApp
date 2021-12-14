import 'package:bloc_news/blocs/News/news_bloc.dart';
import 'package:bloc_news/repositories/news_repository.dart';
import 'package:bloc_news/views/home_screen.dart';
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
                NewsBloc(newsRepository: NewsRepository())..add(NewsRequested()),
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
