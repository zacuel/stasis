import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/authentication/auth_controller.dart';
import 'package:stasis/navigation.dart';

import '../../../models/article.dart';

class LikedArticleTile extends ConsumerWidget {
  final Article article;
  const LikedArticleTile(this.article, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color borderColor = ref.watch(personProvider)!.favoriteColor;
    return GestureDetector(
      onTap: () => navigateToArticle(context, article),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: borderColor, width: 5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(article.title),
            Text(article.authorName),
          ]),
        ),
      ),
    );
  }
}
