import 'package:flutter/material.dart';
import 'package:stasis/navigation.dart';

import '../../models/article.dart';
//TODO make liked article tiles. 
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
    );
  }
}
