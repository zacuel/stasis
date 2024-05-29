import 'package:flutter/widgets.dart';

class Person {
  final String uid;
  final String alias;
  final Color favoriteColor;
  final List<String> favoriteArticleIds;
  Person({
    required this.uid,
    required this.alias,
    required this.favoriteColor,
    required this.favoriteArticleIds,
  });

  // Person copyWith({
  //   String? uid,
  //   String? alias,
  //   Color? favoriteColor,
  //   List<String>? favoriteArticleIds,
  // }) {
  //   return Person(
  //     uid: uid ?? this.uid,
  //     alias: alias ?? this.alias,
  //     favoriteColor: favoriteColor ?? this.favoriteColor,
  //     favoriteArticleIds: favoriteArticleIds ?? this.favoriteArticleIds,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'alias': alias,
      'favoriteColor': favoriteColor.value,
      'favoriteArticleIds': favoriteArticleIds,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      uid: map['uid'] ?? '',
      alias: map['alias'] ?? '',
      favoriteColor: Color(map['favoriteColor']),
      favoriteArticleIds: List<String>.from(map['favoriteArticleIds']),
    );
  }
}
