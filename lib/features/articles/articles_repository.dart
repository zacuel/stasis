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
}
