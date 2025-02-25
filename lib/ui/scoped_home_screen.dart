import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constance.dart';
import '../features/articles/articles_controller.dart';
import '../features/articles/favorite_articles_provider.dart';
import '../features/authentication/auth_controller.dart';
import '../models/article.dart';
import '../models/scope_enum.dart';
import '../navigation.dart';
import '../utils/limit_hit_dialogue.dart';
import 'common/error_loader.dart';
import 'widgets/article_tiles/article_tile.dart';
import 'widgets/article_tiles/liked_article_tile.dart';

class ScopedHomeScreen extends ConsumerStatefulWidget {
  const ScopedHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScopedHomeScreenState();
}

class _ScopedHomeScreenState extends ConsumerState<ScopedHomeScreen> {
  int _currentTabIndex = 0;
  String screenTitle = "local";
  void _goToCreateArticle(int listLength) {
    if (listLength < Constance.maxUpvotes) {
      navigateToCreateArticle(context);
    } else {
      showDialog(context: context, builder: postLimitHitDialogue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final person = ref.watch(personProvider)!;
    final favList = ref.watch(favoriteArticlesProvider);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTabIndex,
          onTap: (value) {
            setState(() {
              _currentTabIndex = value;
              if (value == 0) {
                screenTitle = 'local';
              }
              if (value == 1) {
                screenTitle = 'state';
              }
              if (value == 2) {
                screenTitle = 'national';
              }
              if (value == 3) {
                screenTitle = 'world';
              }
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.house),
              label: "local",
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_sharp),
              label: "state",
              backgroundColor: Colors.yellow,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              label: "national",
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(icon: Icon(Icons.deblur), label: "world", backgroundColor: Colors.blue),
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(screenTitle),
          actions: [
            IconButton(onPressed: () => navigateToSortedFeed(context), icon: const Icon(Icons.format_line_spacing)),
            IconButton(
              onPressed: () => _goToCreateArticle(favList.length),
              icon: const Icon(Icons.add_box_outlined),
            ),
          ],
          leading: IconButton(onPressed: () => navigateToPersonal(context), icon: const Icon(Icons.person)),
        ),
        body: ref.watch(articleFeedProvider).when(
            data: (data) {
              List<Article> articles;
              switch (_currentTabIndex) {
                case 0:
                  articles = data.where((element) => element.scope == Scope.local).toList();
                case 1:
                  articles = data.where((element) => element.scope == Scope.state).toList();
                case 2:
                  articles = data.where((element) => element.scope == Scope.national).toList();
                case 3:
                  articles = data.where((element) => element.scope == Scope.global).toList();
                default:
                  articles = data.where((element) => element.scope == Scope.local).toList();
              }
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  final isFav = favList.contains(article.articleId);
                  if (isFav) {
                    return LikedArticleTile(article);
                  } else {
                    return ArticleTile(article);
                  }
                },
              );
            },
            error: (error, _) => ErrorText(error.toString()),
            loading: () => const Loader()));
  }
}
