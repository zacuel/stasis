
import 'package:flutter/material.dart';

import '../constance.dart';

Widget postLimitHitDialogue(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SimpleDialog(
      title: const Text("you are only allowed ${Constance.maxUpvotes} upclicks"),
      children: [
        const Text(
          "unlike some articles and try again",
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text("ok")),
        )
      ],
    ),
  );
}
