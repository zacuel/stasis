import 'package:flutter/material.dart';
import 'package:stasis/ui/article_screens/link_article_screen.dart';
import 'package:stasis/ui/article_screens/text_article_screen.dart';

import 'models/article.dart';
import 'ui/article_screens/create_article_screen.dart';

navigateToCreateArticle(BuildContext context, String authorName) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) =>  CreateArticleScreen(authorName),
  ));
}

navigateToArticle(BuildContext context, Article article){
  if(article.url == null){
      Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => TextArticleScreen(article),
  ));
  } else {
          Navigator.of(context).push(MaterialPageRoute(
    builder: (context) =>  LinkArticleScreen(article),
  ));
  }
}