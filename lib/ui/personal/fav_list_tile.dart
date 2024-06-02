import 'package:flutter/material.dart';
import 'package:stasis/navigation.dart';

import '../../models/article.dart';
import '../../models/scope_enum.dart';

Color getColor(Article article) {
  switch (article.scope) {
    case Scope.local:
      return Colors.green;
    case Scope.state:
      return Colors.yellow;
    case Scope.national:
      return Colors.red;
    case Scope.global:
      return Colors.blue;
  }
}

class FavListTile extends StatelessWidget {
  final Article article;
  const FavListTile(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: getColor(article),
      title: Text(article.title),
      onTap: () => navigateToArticle(context, article),
    );
  }
}
