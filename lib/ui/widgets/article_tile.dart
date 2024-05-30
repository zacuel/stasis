import 'package:flutter/material.dart';
import 'package:stasis/navigation.dart';

import '../../models/article.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  const ArticleTile(this.article, {super.key});

  _navToArticle(BuildContext context) {
    navigateToArticle(context, article);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navToArticle(context),
      child: Card(
        child: Column(children: [
          Text(article.title),
          Text(article.authorName),
        ]),
      ),
    );
  }
}
