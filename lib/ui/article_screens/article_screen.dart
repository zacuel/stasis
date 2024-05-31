import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/authentication/auth_controller.dart';

import '../../features/comments/comments_controller.dart';
import '../../models/article.dart';
import '../widgets/add_comment_widget.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  final Article article;
  const ArticleScreen(this.article, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  bool _showComments = false, _addingComment = false, _showVoteButton = false;
  final _commentController = TextEditingController();

  void _toggleMenu(String value) {
    setState(() {
      if (value == 'show') {
        _addingComment = false;
        _showComments = true;
        _showVoteButton = false;
      } else if (value == 'add') {
        _showComments = false;
        _addingComment = true;
        _showVoteButton = false;
      } else if (value == 'vote') {
        _showVoteButton = !_showVoteButton;
      }
    });
  }

  void _addComment() async {
    ref.read(commentsControllerProvider.notifier).addComment(context, widget.article.articleId, _commentController.text.trim());
    setState(() {
      _addingComment = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final person = ref.watch(personProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
        actions: [
          PopupMenuButton(
            onSelected: (value) => _toggleMenu(
              value,
            ),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 'show', child: Text("show responses")),
                const PopupMenuItem(value: 'add', child: Text("respond")),
                const PopupMenuItem(value: 'vote', child: Text("show vote button")),
              ];
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: Placeholder()),
            if (_addingComment)
              AddCommentWidget(
                color: person.favoriteColor,
                commentFieldController: _commentController,
                changeComment: _addComment,
              ),
          ],
        ),
      ),
      floatingActionButton: _showVoteButton ? FloatingActionButton(onPressed: () {}) : null,
    );
  }
}
