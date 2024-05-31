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
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: widget.article.content == null
                  ? Text(
                      widget.article.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : Text(widget.article.content!),
            )),
          ],
        ),
      ),
    );
  }
}
