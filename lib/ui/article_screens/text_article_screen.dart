import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/article.dart';

class TextArticleScreen extends ConsumerStatefulWidget {
  final Article article;
  const TextArticleScreen(this.article, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextArticleScreenState();
}

class _TextArticleScreenState extends ConsumerState<TextArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
      ),
      body: Text(widget.article.content ?? widget.article.title),
    );
  }
}
