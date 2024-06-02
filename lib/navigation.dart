import 'package:flutter/material.dart';
import 'package:stasis/ui/personal/favorites_feed.dart';
import 'package:stasis/ui/personal/personal_page.dart';

import 'models/article.dart';
import 'ui/article_screens/article_screen.dart';
import 'ui/article_screens/create_article_screen.dart';

navigateToCreateArticle(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const CreateArticleScreen(),
  ));
}

navigateToArticle(BuildContext context, Article article) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => ArticleScreen(article),
  ));
}

navigateToPersonal(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const PersonalPage(),
  ));
}

navigateToFavFeed(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const FavoritesFeed(),
  ));
}
