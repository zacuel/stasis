import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/authentication/auth_controller.dart';
import 'package:stasis/ui/auth/auth_screen.dart';
import 'package:stasis/ui/common/error_loader.dart';
import 'package:stasis/ui/home_screen.dart';

import 'models/person.dart';
import 'utils/firebase_utils/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  Person? person;
  void getData(User data) async {
    person = await ref.read(authControllerProvider.notifier).getPersonData(data.uid).first;
    ref.read(personProvider.notifier).update((state) => person);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "stasis",
      home: ref.watch(authStateChangeProvider).when(
          data: (data) {
            if (data != null) {
              getData(data);
              if (person != null) {
                return const HomeScreen();
              }
            }
            return const AuthScreen();
          },
          error: (error, _) => ErrorText(error.toString()),
          loading: () => const Loader()),
    );
  }
}
