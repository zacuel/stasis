import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/articles/favorite_articles_provider.dart';

class FavoritesFeed extends ConsumerWidget {
  const FavoritesFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteArticles = ref.watch(favoriteArticlesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("here's the stuff")),
      body: ListView.builder(itemCount: favoriteArticles.length, itemBuilder:(context, index) {
                  final articleId = favoriteArticles[index];
                  
      },),
    );
  }
}
