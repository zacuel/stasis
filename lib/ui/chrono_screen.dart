import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/articles/articles_controller.dart';
import 'package:stasis/navigation.dart';
import 'package:stasis/ui/common/error_loader.dart';
import 'package:stasis/ui/widgets/article_tiles/article_tile.dart';
import 'package:stasis/ui/widgets/article_tiles/liked_article_tile.dart';

import '../constance.dart';
import '../features/articles/favorite_articles_provider.dart';
import '../features/authentication/auth_controller.dart';
import '../utils/limit_hit_dialogue.dart';
import 'widgets/article_tiles/shaded/shaded_article_tile.dart';
import 'widgets/article_tiles/shaded/shaded_liked_article_tile.dart';

class ChronoScreen extends ConsumerStatefulWidget {
  const ChronoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChronoScreenState();
}

class _ChronoScreenState extends ConsumerState<ChronoScreen> {
  bool newestFirst = true;
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
        appBar: AppBar(title: Text(newestFirst ? "newest first" : "oldest first"), actions: [
          IconButton(
              onPressed: () {
                newestFirst = !newestFirst;
              },
              icon: const Icon(Icons.format_line_spacing))
        ]),
        body: ref.watch(sortedArticleProvider(newestFirst)).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final article = data[index];
                  final isFav = favList.contains(article.articleId);
                  if (isFav) {
                    return ShadedLikedArticleTile(article);
                  } else {
                    return ShadedArticleTile(article);
                  }
                },
              );
            },
            error: (error, _) => ErrorText(error.toString()),
            loading: () => const Loader()));
  }
}
