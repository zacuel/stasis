import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/comment.dart';
import '../../features/comments/comments_controller.dart';
import '../common/error_loader.dart';


class CommentsWidget extends ConsumerWidget {
  final String articleId;
  const CommentsWidget(this.articleId, {super.key});

  Widget _commentText(
    String commentText,
    String author,
  ) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 1,
          ),
          Text(
            '"$commentText"',
            style: const TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
          Text("- $author"),
        ],
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(.1),
        borderRadius: const BorderRadius.vertical(
          top: Radius.elliptical(150, 70),
        ),
      ),
      height: 160,
      width: double.infinity,
      // padding: const EdgeInsets.all(12),
      child: ref.watch(articleCommentsProvider(articleId)).when(
            data: (comments) {
              if (comments.isNotEmpty) {
                return PageView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    // if (index == 0) {
                    //   return _commentText('swipe for next comment', '');
                    // } else {
                      final Comment comment = comments[index];
                      return _commentText(comment.commentText, comment.authorAlias);
                    // }
                  },
                );
              } else {
                return const Center(child: Text("No comments yet"));
              }
            },
            error: (error, stackTrace) {

              return ErrorText(error.toString());
            },
            loading: () => const Loader(),
          ),
    );
  }
}
