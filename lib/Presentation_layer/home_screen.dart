import 'dart:io';

import 'package:bloc_news/Logic_layer/News/news_bloc.dart';
import 'package:bloc_news/Data_layer/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> refresh() async =>
      context.read<NewsBloc>()..add(NewsRequested());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xff4d4d4d),
            title: Text(
              "Latest News".toUpperCase(),
              style: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'PantonBoldItalic',
                  color: Color(0xff0892fd)),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: refresh,
            child: Stack(
              children: [
                Container(
                  color: const Color(0xff585858),
                  child: BlocBuilder<NewsBloc, NewsState>(
                    builder: (BuildContext context, NewsState state) {
                      if (state is NewsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is NewsLoaded) {
                        List<ArticleModel> _articleList = [];
                        _articleList = state.articleList!;
                        return ListView.builder(
                            itemCount: _articleList.length,
                            itemBuilder: (context, index) {
                              if (_articleList[index].title == null ||
                                  _articleList[index].urlToImage == null) {
                                return Container();
                              } else {
                                return GestureDetector(
                                  onTap: () async {
                                    if (Platform.isAndroid) {
                                      FlutterWebBrowser.openWebPage(
                                        url: _articleList[index].url!,
                                        customTabsOptions:
                                            const CustomTabsOptions(
                                          colorScheme:
                                              CustomTabsColorScheme.dark,
                                          addDefaultShareMenuItem: true,
                                          defaultColorSchemeParams:
                                              CustomTabsColorSchemeParams(
                                                  toolbarColor:
                                                      Color(0xff0892fd),
                                                  secondaryToolbarColor:
                                                      Colors.grey,
                                                  navigationBarColor:
                                                      Colors.grey),
                                          instantAppsEnabled: true,
                                          showTitle: true,
                                          urlBarHidingEnabled: true,
                                        ),
                                      );
                                    } else if (Platform.isIOS) {
                                      FlutterWebBrowser.openWebPage(
                                        url: _articleList[index].url!,
                                        safariVCOptions:
                                            const SafariViewControllerOptions(
                                          barCollapsingEnabled: true,
                                          preferredBarTintColor: Colors.grey,
                                          preferredControlTintColor:
                                              Colors.grey,
                                          dismissButtonStyle:
                                              SafariViewControllerDismissButtonStyle
                                                  .close,
                                          modalPresentationCapturesStatusBarAppearance:
                                              true,
                                        ),
                                      );
                                    } else {
                                      await FlutterWebBrowser.openWebPage(
                                          url: _articleList[index].url!);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xff585858),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0xff434242),
                                              offset: Offset(0, 3),
                                              spreadRadius: 3)
                                        ]),
                                    height: height * 0.15,
                                    margin: EdgeInsets.only(
                                        top: height * 0.025,
                                        left: width * 0.04,
                                        right: width * 0.04),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: width * 0.3,
                                          height: height * 0.15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    _articleList[index]
                                                        .urlToImage!,
                                                  ),
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        Container(
                                          height: height * 0.15,
                                          width: width * 0.55,
                                          padding: EdgeInsets.symmetric(
                                              vertical: height * 0.01),
                                          child: Text(
                                            _articleList[index].title!,
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            });
                      } else if (state is NewsError) {
                        String error = state.errorMessage!;

                        return Center(child: Text(error));
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Color(0xff0892fd),
                        ));
                      }
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
