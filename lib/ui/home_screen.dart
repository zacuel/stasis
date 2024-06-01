import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/articles/articles_controller.dart';
import 'package:stasis/navigation.dart';
import 'package:stasis/ui/common/error_loader.dart';
import 'package:stasis/ui/widgets/article_tile.dart';
import 'package:stasis/ui/widgets/liked_article_tile.dart';

import '../constance.dart';
import '../features/articles/favorite_articles_provider.dart';
import '../features/authentication/auth_controller.dart';
import '../utils/limit_hit_dialogue.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
        appBar: AppBar(actions: [IconButton(onPressed: () => _goToCreateArticle(favList.length), icon: const Icon(Icons.add_box_outlined))]),
        body: ref.watch(articleFeedProvider).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final article = data[index];
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
