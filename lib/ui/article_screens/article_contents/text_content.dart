import 'package:flutter/material.dart';

class TextContent extends StatelessWidget {
  final String content;
  const TextContent(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(content);
  }
}
