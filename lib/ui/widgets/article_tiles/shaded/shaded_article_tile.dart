import 'package:flutter/material.dart';
import 'package:stasis/color_by_locale.dart';
import 'package:stasis/navigation.dart';

import '../../../../models/article.dart';

//TODO make liked article tiles.
class ShadedArticleTile extends StatelessWidget {
  final Article article;
  const ShadedArticleTile(this.article, {super.key});

  _navToArticle(BuildContext context) {
    navigateToArticle(context, article);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () => _navToArticle(context),
        child: Card(
          color: colorByLocale(article.scope).withOpacity(.3),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Text(article.title),
              const SizedBox(
                height: 10,
              ),
              Text(article.authorName),
            ]),
          ),
        ),
      ),
    );
  }
}
