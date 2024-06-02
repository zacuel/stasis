import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/navigation.dart';

import '../../features/authentication/auth_controller.dart';

class PersonalPage extends ConsumerStatefulWidget {
  const PersonalPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonalPageState();
}

// popUpNameChanger(BuildContext context) {
//   showDialog(context: context, builder:(context) {

//   },);
// }

class _PersonalPageState extends ConsumerState<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    final person = ref.watch(personProvider)!;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        person.alias,
        style: const TextStyle(fontFamily: "ComicSans"),
      )),
      body: Center(
        child: Column(
          children: [
            // ListTile(
            //   onTap: () {}
            //   title: const Text("Pick Your Color(not your nose)"),
            // ),
            ListTile(
              onTap: () => navigateToFavFeed(context),
              title: const Text("view your selections"),
            ),
            // ListTile(
            //   onTap: () => navigateToNameChange(context, person.alias),
            //   title: const Text('change your username'),
            // ),
          ],
        ),
      ),
    );
  }
}
