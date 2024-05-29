import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/articles/articles_controller.dart';
import 'package:stasis/navigation.dart';
import 'package:stasis/ui/common/error_loader.dart';

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
        appBar:
            AppBar(actions: [IconButton(onPressed: () => navigateToCreateArticle(context, person.alias), icon: const Icon(Icons.add_box_outlined))]),
        body: ref.watch(articleFeedProvider).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final article = data[index];
                  return Text(article.title);
                },
              );
            },
            error: (error, _) => ErrorText(error.toString()),
            loading: () => const Loader()));
  }
}
