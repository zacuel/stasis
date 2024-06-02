import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/articles/articles_controller.dart';
import 'package:stasis/features/articles/favorite_articles_provider.dart';
import 'package:stasis/ui/common/error_loader.dart';
import 'package:stasis/ui/personal/fav_list_tile.dart';

import '../../features/authentication/auth_controller.dart';

class FavoritesFeed extends ConsumerWidget {
  const FavoritesFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteArticles = ref.watch(favoriteArticlesProvider);
    final person = ref.watch(personProvider)!;
    return Scaffold(
      appBar: AppBar(title: const Text("here's the stuff")),
      body: ListView.builder(
        itemCount: favoriteArticles.length,
        itemBuilder: (context, index) {
          final articleId = favoriteArticles[index];
          return ref.watch(articleByIdProvider(articleId)).when(
              data: (article) {
                return FavListTile(article);
              },
              error: (error, _) => ListTile(
                    title: const Text('article is deleted, tap here to remove'),
                    onTap: () {
                      ref.read(favoriteArticlesProvider.notifier).removeUponDiscoveredDeletion(person.uid, articleId);
                    },
                  ),
              loading: () => const Loader());
        },
      ),
    );
  }
}
