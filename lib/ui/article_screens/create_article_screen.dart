import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stasis/features/authentication/auth_controller.dart';

import '../../features/articles/articles_controller.dart';
import '../../models/scope_enum.dart';
import '../../utils/snackybar.dart';
import '../../utils/text_validation.dart';
import '../common/error_loader.dart';

enum PageSelector {
  opener,
  textArticle,
  linkArticle,
  closer,
}

class CreateArticleScreen extends ConsumerStatefulWidget {

  const CreateArticleScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends ConsumerState<CreateArticleScreen> {
  PageSelector _pageSelector = PageSelector.opener;
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  final _contentController = TextEditingController();
  final _attributionController = TextEditingController();
  bool _isLink = false;
  late String authorName;
  Scope scope = Scope.local;

  @override
  void initState() {
    super.initState();
    authorName = ref.read(personProvider)!.alias;
  }

  _changePage(PageSelector newValue) {
    setState(() {
      _pageSelector = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_pageSelector) {
      case PageSelector.opener:
        return _opener;
      case PageSelector.linkArticle:
        return _shareLink;
      case PageSelector.textArticle:
        return _shareText;
      case PageSelector.closer:
        return _finalSection;
      default:
        return const ErrorText("something went wrong, coding error");
    }
  }

  _toggleIsLink(bool? value) {
    setState(() {
      _isLink = value!;
    });
  }

  _confirmSectionOne() {
    if (validTextValue(_titleController)) {
      if (!_isLink) {
        _changePage(PageSelector.textArticle);
      } else {
        if (Uri.parse(_urlController.text).isAbsolute) {
          _changePage(PageSelector.linkArticle);
        } else {
          showSnackBar(context, "This Url is not valid");
        }
      }
    } else {
      showSnackBar(context, "we need a title");
    }
  }

  Scaffold get _opener => Scaffold(
        appBar: AppBar(
          title: const Text("Section One"),
          actions: [IconButton(onPressed: _confirmSectionOne, icon: const Icon(Icons.arrow_forward))],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text('title goes here'),
                TextField(
                  controller: _titleController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: "Roboto"),
                ),
              ],
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('are you sharing a link or plain text?'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(title: const Text('link'), value: true, groupValue: _isLink, onChanged: _toggleIsLink),
                    ),
                    Expanded(
                      child: RadioListTile(title: const Text('text'), value: false, groupValue: _isLink, onChanged: _toggleIsLink),
                    ),
                  ],
                ),
                if (_isLink)
                  TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(hintText: 'url goes here'),
                  ),
              ],
            ),
            OutlinedButton(
                onPressed: _confirmSectionOne,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('next section'),
                )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );

  Scaffold get _shareText => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _changePage(PageSelector.opener),
          ),
          title: const Text("copy/paste recommended"),
          actions: [
            IconButton(
              onPressed: () => _changePage(PageSelector.closer),
              icon: const Icon(Icons.arrow_forward),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(hintText: 'content goes here'),
                  maxLines: 999999,
                  controller: _contentController,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _changePage(PageSelector.closer);
                },
                child: const Text('next section')),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );

  Scaffold get _shareLink => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _changePage(PageSelector.opener),
          ),
          title: const Text("Section Two"),
          actions: [IconButton(onPressed: () => _changePage(PageSelector.closer), icon: const Icon(Icons.arrow_forward))],
        ),
        body: Column(
          children: [
            Text(
              _urlController.text,
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              'optionally, you can add your own content in addition to the link',
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 99999,
                  controller: _contentController,
                ),
              ),
            ),
            ElevatedButton(onPressed: () => _changePage(PageSelector.closer), child: const Text('next section')),
          ],
        ),
      );

  Scaffold get _finalSection {
    final isLoading = ref.watch(articlesControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _changePage(_isLink ? PageSelector.linkArticle : PageSelector.textArticle),
        ),
        title: const Text("additional options"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(' add authorship as you wish, anonymity is not guaranteed'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("attributing to $authorName"),
                TextButton(onPressed: _changeAttribution, child: const Text("(change)")),
              ],
            ),
            const Text('select which scope this concerns'),
            Column(
              children: [
                RadioListTile<Scope>(
                  value: Scope.local,
                  groupValue: scope,
                  onChanged: _changeScope,
                  title: const Text('local'),
                ),
                RadioListTile<Scope>(value: Scope.state, groupValue: scope, onChanged: _changeScope, title: const Text('state')),
                RadioListTile<Scope>(value: Scope.national, groupValue: scope, onChanged: _changeScope, title: const Text('national')),
                RadioListTile<Scope>(value: Scope.global, groupValue: scope, onChanged: _changeScope, title: const Text('global')),
              ],
            ),
            isLoading ? const CircularProgressIndicator() : ElevatedButton(onPressed: _submitPost, child: const Text("submit submission")),
          ],
        ),
      ),
    );
  }

  void _submitPost() {
    if (_isLink) {
      ref.read(articlesControllerProvider.notifier).shareLink(
            link: validTextValueReturner(_urlController),
            context: context,
            title: validTextValueReturner(_titleController),
            authorName: authorName,
            scope: scope,
            content: validTextValue(_contentController) ? validTextValueReturner(_contentController) : null,
          );
    } else {
      ref.read(articlesControllerProvider.notifier).shareText(
            context: context,
            title: validTextValueReturner(_titleController),
            content: validTextValue(_contentController) ? validTextValueReturner(_contentController) : null,
            authorName: authorName,
            scope: scope,
          );
    }
    Navigator.of(context).pop();
  }

  void _changeScope(Scope? newValue) {
    setState(() {
      scope = newValue!;
    });
  }

  void _changeAttribution() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Dialog(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              height: 180,
              child: Column(
                children: [
                  TextField(
                    controller: _attributionController,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (validTextValue(_attributionController)) {
                              authorName = _attributionController.text.trim();
                            } else {
                              authorName = "anonymous";
                            }
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('change'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _urlController.dispose();
    _contentController.dispose();
    _attributionController.dispose();
  }
}
