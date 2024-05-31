import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/article.dart';

class LinkArticleScreen extends ConsumerStatefulWidget {
  final Article article;
  const LinkArticleScreen(this.article, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinkArticleScreenState();
}

class _LinkArticleScreenState extends ConsumerState<LinkArticleScreen> {
  _launchUrl() async {
    final Uri url = Uri.parse(widget.article.url!);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
        actions: [
          
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: _launchUrl,
                      child: Text(widget.article.url!),
                    ),
                    if (widget.article.content != null) Text(widget.article.content!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
