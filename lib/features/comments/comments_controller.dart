import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/snackybar.dart';
import '../authentication/auth_controller.dart';
import 'comments_repository.dart';

final commentsControllerProvider = Provider<CommentsController>((ref) {
  final commentsRepository = ref.read(commentsRepositoryProvider);
  return CommentsController(commentRepository: commentsRepository, ref: ref);
});

class CommentsController {
  final CommentsRepository _commentRepository;
  final Ref _ref;
  CommentsController({required CommentsRepository commentRepository, required Ref ref})
      : _commentRepository = commentRepository,
        _ref = ref;

  void addComment(BuildContext context, String articleId, String comment) async {
    final person = _ref.read(personProvider)!;

    final result = await _commentRepository.addComment(articleId, person.uid, person.alias, comment);
    result.fold((l) => showSnackBar(context, l.message), (r) => null);
  }


    Future<String> getUserComment(String articleId) async {
    final person = _ref.read(personProvider)!;
    final comment = await _commentRepository.getUserComment(articleId, person.uid);
    return comment;
  }
}
