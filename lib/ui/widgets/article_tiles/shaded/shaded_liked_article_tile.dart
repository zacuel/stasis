import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/color_by_locale.dart';
import 'package:stasis/features/authentication/auth_controller.dart';
import 'package:stasis/navigation.dart';

import '../../../../models/article.dart';

class ShadedLikedArticleTile extends ConsumerWidget {
  final Article article;
  const ShadedLikedArticleTile(this.article, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color borderColor = ref.watch(personProvider)!.favoriteColor;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () => navigateToArticle(context, article),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: borderColor, width: 5), color: colorByLocale(article.scope).withOpacity(.3)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Text(article.title),
              const SizedBox(
                height: 8,
              ),
              Text(article.authorName),
            ]),
          ),
        ),
      ),
    );
  }
}
