import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../models/article.dart';
import '../../utils/firebase_utils/firebase_providers.dart';
import '../../utils/type_defs.dart';

final articlesRepositoryProvider = Provider<ArticlesRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return ArticlesRepository(firestore: firestore);
});

class ArticlesRepository {
  final FirebaseFirestore _firestore;

  ArticlesRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  CollectionReference get _articles => _firestore.collection('articles');

  FutureEitherFailureOr<void> postArticle(Article article) async {
    try {
      return right(_articles.doc(article.articleId).set(article.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Article>> get articleFeed =>
      _articles.snapshots().map((event) => event.docs.map((e) => Article.fromMap(e.data() as Map<String, dynamic>)).toList());
  Stream<List<Article>> get oldestToNewest =>
      _articles.orderBy("createdAt").snapshots().map((event) => event.docs.map((e) => Article.fromMap(e.data() as Map<String, dynamic>)).toList());
  Stream<List<Article>> get newestToOldest => _articles
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map((event) => event.docs.map((e) => Article.fromMap(e.data() as Map<String, dynamic>)).toList());

  Stream<Article> streamArticleById(String articleId) => _articles.doc(articleId).snapshots().map(
        (event) => Article.fromMap(event.data() as Map<String, dynamic>),
      );

  void downvote(Article article, String userId) async {
    if (article.upvoteIds.contains(userId)) {
      await _articles.doc(article.articleId).update({
        'upvoteIds': FieldValue.arrayRemove([userId]),
        'score': article.score - 1,
      });
    }
  }

  void upvote(Article article, String userId) async {
    if (!article.upvoteIds.contains(userId)) {
      await _articles.doc(article.articleId).update({
        'upvoteIds': FieldValue.arrayUnion([userId]),
        'score': article.score + 1,
      });
    }
  }
}
