import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/articles/articles_repository.dart';
import 'package:uuid/uuid.dart';

import '../../models/article.dart';
import '../../models/scope_enum.dart';
import '../../utils/snackybar.dart';
import '../authentication/auth_controller.dart';

final articlesControllerProvider = StateNotifierProvider<ArticlesController, bool>((ref) {
  final articleRepository = ref.watch(articlesRepositoryProvider);
  return ArticlesController(articlesRepository: articleRepository, ref: ref);
});

class ArticlesController extends StateNotifier<bool> {
  final ArticlesRepository _articlesRepository;
  final Ref _ref;

  ArticlesController({required ArticlesRepository articlesRepository, required Ref ref})
      : _articlesRepository = articlesRepository,
        _ref = ref,
        super(false);

  Future<void> shareText({
    required BuildContext context,
    required String title,
    String? content,
    required String authorName,
    required Scope scope,
  }) async {
    state = true;
    String newId = const Uuid().v1();
    final user = _ref.read(personProvider)!;
    final article = Article(
      content: content,
      authorName: authorName,
      articleId: newId,
      authorId: user.uid,
      createdAt: DateTime.now(),
      upvoteIds: [user.uid],
      title: title,
      score: 1,
      scope: scope,
    );

    final result = await _articlesRepository.postArticle(article);
    state = false;
    result.fold((l) => showSnackBar(context, l.message), (r) {
      // _ref.read(favoriteArticlesProvider.notifier).addArticleUponCreation(article.articleId);
      showSnackBar(context, 'success!');
    });
  }

  Future<void> shareLink({
    required String link,
    required BuildContext context,
    required String title,
    String? content,
    required String authorName,
    required Scope scope,
  }) async {
    state = true;
    String newId = const Uuid().v1();
    final user = _ref.read(personProvider)!;
    final article = Article(
      url: link,
      content: content,
      authorName: authorName,
      articleId: newId,
      authorId: user.uid,
      createdAt: DateTime.now(),
      upvoteIds: [user.uid],
      title: title,
      score: 1,
      scope: scope,
    );
    final result = await _articlesRepository.postArticle(article);
    state = false;
    result.fold((l) => showSnackBar(context, l.message), (r) {
      // _ref.read(favoriteArticlesProvider.notifier).addArticleUponCreation(article.articleId);
      showSnackBar(context, 'success!');
    });
  }
}
