import 'package:flutter/material.dart';

import 'ui/article_screens/create_article_screen.dart';

navigateToCreateArticle(BuildContext context, String authorName) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) =>  CreateArticleScreen(authorName),
  ));
}