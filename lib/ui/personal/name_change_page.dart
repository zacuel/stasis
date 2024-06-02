import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/authentication/auth_controller.dart';
import '../../navigation.dart';

const mirrorTextStyle = TextStyle(fontSize: 26, fontWeight: FontWeight.bold);

class NameChangePage extends ConsumerStatefulWidget {
  final String currentUsername;
  const NameChangePage(this.currentUsername, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NameChangePageState();
}

class _NameChangePageState extends ConsumerState<NameChangePage> {
  late String seeName;

  @override
  void initState() {
    super.initState();
    seeName = widget.currentUsername;
  }

  @override
  Widget build(BuildContext context) {
    final person = ref.watch(personProvider)!;
    return Scaffold(
      backgroundColor: person.favoriteColor.withOpacity(.2),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigateToHome(context);
          },
        ),
        title: const Text("change username here"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              seeName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.rotate(
                angle: -.45,
                child: Text(
                  seeName,
                  style: const TextStyle(fontSize: 19),
                )),
          ),
          Align(alignment: Alignment.centerLeft, child: Transform.rotate(angle: .1, child: Text('     $seeName'))),
          const SizedBox(
            height: 50,
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                seeName = value;
              });
            },
            style: mirrorTextStyle,
            textAlign: TextAlign.center,
          ),
          Transform.flip(
            flipY: true,
            child: Text(
              seeName,
              style: mirrorTextStyle,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    navigateToHome(context);
                  },
                  child: const Text('cancel')),
              ElevatedButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).changeAlias(seeName);
                  navigateToHome(context);
                },
                child: const Text('ok'),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                seeName,
                style: const TextStyle(fontSize: 7),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
