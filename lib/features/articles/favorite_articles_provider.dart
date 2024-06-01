import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../authentication/auth_repository.dart';
import 'articles_controller.dart';


final favoriteArticlesProvider = StateNotifierProvider<FavoriteArticlesNotifier, List<String>>((ref) {
  final articlesController = ref.read(articlesControllerProvider.notifier);
  final authRepository = ref.read(authRepositoryProvider);
  return FavoriteArticlesNotifier(articlesController: articlesController, authRepository: authRepository);
});

class FavoriteArticlesNotifier extends StateNotifier<List<String>> {
  final ArticlesController _articlesController;
  final AuthRepository _authRepository;
  FavoriteArticlesNotifier({required ArticlesController articlesController, required AuthRepository authRepository})
      : _articlesController = articlesController,
        _authRepository = authRepository,
        super([]);

  void toggleArticleFavoriteStatus(String articleId) {
    final isFavorite = state.contains(articleId);
    if (isFavorite) {
      state = state.where((element) => element != articleId).toList();
      _articlesController.downvoteFromArticleId(articleId);
    } else {
      state = [...state, articleId];
      _articlesController.upvoteWithOneStep(articleId);
    }
  }

  void addArticleUponCreation(String articleId) {
    state = [...state, articleId];
    _articlesController.upvoteWithOneStep(articleId);
  }

  void removeUponDiscoveredDeletion(String uid, String articleId) {
    state = state.where((element) => element != articleId).toList();
    _authRepository.downvote(uid, articleId);
  }

  void createListState(List<String> articleList) {
    state = articleList;
  }
}
