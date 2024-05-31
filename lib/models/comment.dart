class Comment {
  final String authorAlias;
  final String commentText;

  Comment({
    required this.authorAlias,
    required this.commentText,
  });

  Comment copyWith({
    String? authorAlias,
    String? commentText,
    List<String>? upvoteIds,
  }) {
    return Comment(
      authorAlias: authorAlias ?? this.authorAlias,
      commentText: commentText ?? this.commentText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authorAlias': authorAlias,
      'commentText': commentText,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      authorAlias: map['authorAlias'] ?? '',
      commentText: map['commentText'] ?? '',
    );
  }
}
