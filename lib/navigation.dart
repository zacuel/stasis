import 'package:flutter/material.dart';

import 'models/article.dart';
import 'ui/article_screens/article_screen.dart';
import 'ui/article_screens/create_article_screen.dart';

navigateToCreateArticle(BuildContext context, String authorName) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => CreateArticleScreen(authorName),
  ));
}

navigateToArticle(BuildContext context, Article article) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => ArticleScreen(article),
  ));
}
