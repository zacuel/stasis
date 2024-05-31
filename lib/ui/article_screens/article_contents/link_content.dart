import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkContent extends StatelessWidget {
  final String url;
  final String? content;
  const LinkContent({super.key, required this.url, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        TextButton(
          onPressed: () async {
            final Uri linkUrl = Uri.parse(url);
            if (!await launchUrl(linkUrl)) {
              throw Exception('Could not launch $url');
            }
          },
          child: Text(
            url,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        if (content != null) Text(content!),
      ],
    );
  }
}
