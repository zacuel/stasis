import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../models/comment.dart';
import '../../utils/firebase_utils/firebase_providers.dart';
import '../../utils/type_defs.dart';

final commentsRepositoryProvider = Provider<CommentsRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return CommentsRepository(firestore: firestore);
});


class CommentsRepository {
  final FirebaseFirestore _firestore;

  CommentsRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  CollectionReference get _articles => _firestore.collection('articles');
  CollectionReference _articleComments(String articleId) => _articles.doc(articleId).collection('comments');

  FutureEitherFailureOr<void> addComment(String articleId, String userId, String userAlias, String commentText) async {
    try {
      if (commentText.trim() == "") {
        return right(_articleComments(articleId).doc(userId).delete());
      } else {
        final comment = Comment(
          authorAlias: userAlias,
          commentText: commentText,
        );
        return right(_articleComments(articleId).doc(userId).set(comment.toMap()));
      }
    } on FirebaseException {
      return left(Failure('something went wrong(firebase exception)'));
    } catch (e) {
      return left(Failure('something went wrong'));
    }
  }

    Future<String> getUserComment(String articleId, String userId) async {
    final document = await _articleComments(articleId).doc(userId).snapshots().first;
    if (_isDocumentExist(document)) {
      final data = document.data() as Map<String, dynamic>;
      return data['commentText'];
    } else {
      return '';
    }
  }

  bool _isDocumentExist(DocumentSnapshot document) {
    if (document.exists) {
      return true;
    } else {
      return false;
    }
  }

    Stream<List<Comment>> getArticleComments(String articleId) {
    return _articleComments(articleId).snapshots().map((event) => event.docs.map((e) => Comment.fromMap(e.data() as Map<String, dynamic>)).toList());
  }
}
