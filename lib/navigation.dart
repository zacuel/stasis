import 'package:flutter/material.dart';
import 'package:stasis/ui/home_screen.dart';
import 'package:stasis/ui/personal/favorites_feed.dart';
import 'package:stasis/ui/personal/personal_page.dart';

import 'models/article.dart';
import 'ui/article_screens/article_screen.dart';
import 'ui/article_screens/create_article_screen.dart';
import 'ui/personal/color_picker_screen.dart';
import 'ui/personal/name_change_page.dart';

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

void navigateToHome(BuildContext context) {
  while (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}

navigateToColorPicking(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const ColorPickerScreen(),
    ),
  );
}

navigateToNameChange(BuildContext context, String username) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => NameChangePage(username),
    ),
  );
}

navigateToSortedFeed(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen()));
}
