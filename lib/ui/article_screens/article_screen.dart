import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/authentication/auth_controller.dart';
import 'package:stasis/ui/article_screens/article_contents/link_content.dart';
import 'package:stasis/ui/article_screens/article_contents/text_content.dart';

import '../../constance.dart';
import '../../features/articles/favorite_articles_provider.dart';
import '../../features/comments/comments_controller.dart';
import '../../models/article.dart';
import '../../utils/limit_hit_dialogue.dart';
import '../widgets/comment_widgets/add_comment_widget.dart';
import '../widgets/comment_widgets/comments_widget.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  final Article article;
  const ArticleScreen(this.article, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  bool _showComments = false, _addingComment = false, _showVoteButton = false;
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserComment();
  }

  void _getUserComment() async {
    _commentController.text = await ref.read(commentsControllerProvider).getUserComment(widget.article.articleId);
  }

  void _toggleMenu(String value) {
    setState(() {
      if (value == 'show') {
        _addingComment = false;
        _showComments = !_showComments;
        _showVoteButton = false;
      } else if (value == 'add') {
        _showComments = false;
        _addingComment = !_addingComment;
        _showVoteButton = false;
      } else if (value == 'vote') {
        _showVoteButton = !_showVoteButton;
        _addingComment = false;
        _showComments = false;
      }
    });
  }

  void _addComment() async {
    ref.read(commentsControllerProvider).addComment(context, widget.article.articleId, _commentController.text.trim());
    setState(() {
      _addingComment = false;
    });
  }

  void _vote(int listLength, isDownVoting) {
    if (listLength < Constance.maxUpvotes || isDownVoting) {
      ref.read(favoriteArticlesProvider.notifier).toggleArticleFavoriteStatus(widget.article.articleId);
    } else {
      showDialog(context: context, builder: postLimitHitDialogue);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final person = ref.watch(personProvider)!;
    final favoriteArticleIds = ref.watch(favoriteArticlesProvider);
    final isLiked = favoriteArticleIds.contains(widget.article.articleId);
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
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: widget.article.url == null
                  ? TextContent(widget.article.content ?? widget.article.title)
                  : LinkContent(
                      url: widget.article.url!,
                      content: widget.article.content,
                    ),
            )),
            if (_showComments) CommentsWidget(widget.article.articleId),
            if (_addingComment)
              AddCommentWidget(
                // color: person.favoriteColor,
                commentFieldController: _commentController,
                changeComment: _addComment,
              ),
          ],
        ),
      ),
      floatingActionButton: _showVoteButton
          ? FloatingActionButton(
              onPressed: () {
                _vote(favoriteArticleIds.length, isLiked);
                setState(() {
                  _showVoteButton = false;
                });
              },
              child: Icon(isLiked ? Icons.horizontal_rule : Icons.thumb_up_sharp),
            )
          : null,
    );
  }
}
