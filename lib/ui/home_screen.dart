import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/navigation.dart';

import '../features/authentication/auth_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final person = ref.watch(personProvider)!;
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: () => navigateToCreateArticle(context), icon: const Icon(Icons.add_box_outlined))]),
      body: Center(
        child: Text(person.alias),
      ),
    );
  }
}
