

import 'scope_enum.dart';

class Article {
  final String articleId;
  final String authorId;
  final DateTime createdAt;
  final String title;
  final String? url;
  final String? content;
  final String authorName;
  final List<String> upvoteIds;
  final int score;
  final Scope scope;
  Article({
    required this.articleId,
    required this.authorId,
    required this.createdAt,
    required this.title,
    this.url,
    this.content,
    required this.authorName,
    required this.upvoteIds,
    required this.score,
    required this.scope,
  });

  // Article copyWith({
  //   String? articleId,
  //   String? authorId,
  //   DateTime? createdAt,
  //   String? title,
  //   ValueGetter<String?>? url,
  //   ValueGetter<String?>? content,
  //   String? authorName,
  //   List<String>? upvoteIds,
  //   int? score,
  //   Scope? scope,
  // }) {
  //   return Article(
  //     articleId: articleId ?? this.articleId,
  //     authorId: authorId ?? this.authorId,
  //     createdAt: createdAt ?? this.createdAt,
  //     title: title ?? this.title,
  //     url: url != null ? url() : this.url,
  //     content: content != null ? content() : this.content,
  //     authorName: authorName ?? this.authorName,
  //     upvoteIds: upvoteIds ?? this.upvoteIds,
  //     score: score ?? this.score,
  //     scope: scope ?? this.scope,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'articleId': articleId,
      'authorId': authorId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'title': title,
      'url': url,
      'content': content,
      'authorName': authorName,
      'upvoteIds': upvoteIds,
      'score': score,
      'scope': scope.index,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      articleId: map['articleId'] ?? '',
      authorId: map['authorId'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      title: map['title'] ?? '',
      url: map['url'],
      content: map['content'],
      authorName: map['authorName'] ?? '',
      upvoteIds: List<String>.from(map['upvoteIds']),
      score: map['score']?.toInt() ?? 0,
      scope: Scope.values.elementAt(map['scope']),
    );
  }
}
