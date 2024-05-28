import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/person.dart';
import '../../utils/snackybar.dart';
import 'auth_repository.dart';

final personProvider = StateProvider<Person?>((ref) => null);

final authStateChangeProvider = StreamProvider<User?>((ref) {
  final authController = ref.read(authControllerProvider.notifier);
  return authController.authStateChange;
});

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    final authRepository = ref.read(authRepositoryProvider);
    return AuthController(authRepository: authRepository, ref: ref);
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Future<void> signUp(String email, String password, String alias, BuildContext context) async {
    state = true;
    final result = await _authRepository.signUp(email, password, alias);
    state = false;
    result.fold((l) => showSnackBar(context, l.message), (r) {
      _ref.read(personProvider.notifier).update((state) => r);
    });
  }

  Future<void> logIn(String email, String password, BuildContext context) async {
    state = true;
    final result = await _authRepository.logIn(email, password);
    state = false;
    result.fold((l) => showSnackBar(context, l.message), (r) {
      _ref.read(personProvider.notifier).update((state) => r);
    });
  }
}
