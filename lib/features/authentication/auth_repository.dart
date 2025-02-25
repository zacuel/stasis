import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stasis/utils/type_defs.dart';

import '../../models/person.dart';
import '../../utils/firebase_utils/firebase_providers.dart';

Color get randomColor {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(255),
    random.nextInt(255),
    random.nextInt(255),
    1,
  );
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  final auth = ref.read(authProvider);
  return AuthRepository(firestore: firestore, auth: auth);
});

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  AuthRepository({required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _auth = auth,
        _firestore = firestore;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  CollectionReference get _people => _firestore.collection('people');

//NOTE used to be Person, not void, and _ref was used in the controller to set the personProvider. removed because it happens in main.
  FutureEitherFailureOr<void> signUp(String email, String password, String alias) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final person = Person(uid: userCredential.user!.uid, alias: alias, favoriteColor: randomColor, favoriteArticleIds: []);
      await _people.doc(person.uid).set(person.toMap());
      return right(null);
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<Person> getPersonData(String uid) {
    return _people.doc(uid).snapshots().map((event) => Person.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureEitherFailureOr<void> logIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // final person = await getPersonData(userCredential.user!.uid).first;
      return right(null);
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

    void downvote(String uid, String articleId) async {
    await _people.doc(uid).update({
      'favoriteArticleIds': FieldValue.arrayRemove([articleId]),
    });
  }

    void upvote(Person person, String articleId) async {
    if (!person.favoriteArticleIds.contains(articleId)) {
      await _people.doc(person.uid).update({
        'favoriteArticleIds': FieldValue.arrayUnion([articleId]),
      });
    }
  }

    void changeFavoriteColor(String uid, int colorValue) {
    _people.doc(uid).update({'favoriteColor': colorValue});
  }

  void changeUserName(String uid, String username) {
    _people.doc(uid).update({'alias': username});
  }
}
