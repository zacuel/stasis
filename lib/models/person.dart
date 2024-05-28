import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  Person copyWith({
    String? uid,
    String? alias,
    Color? favoriteColor,
    List<String>? favoriteArticleIds,
  }) {
    return Person(
      uid: uid ?? this.uid,
      alias: alias ?? this.alias,
      favoriteColor: favoriteColor ?? this.favoriteColor,
      favoriteArticleIds: favoriteArticleIds ?? this.favoriteArticleIds,
    );
  }

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

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Person(uid: $uid, alias: $alias, favoriteColor: $favoriteColor, favoriteArticleIds: $favoriteArticleIds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Person &&
      other.uid == uid &&
      other.alias == alias &&
      other.favoriteColor == favoriteColor &&
      listEquals(other.favoriteArticleIds, favoriteArticleIds);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      alias.hashCode ^
      favoriteColor.hashCode ^
      favoriteArticleIds.hashCode;
  }
}
