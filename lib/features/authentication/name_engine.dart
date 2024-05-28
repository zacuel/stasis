import 'dart:math';

const List<String> adjectives = ['Absolute', 'Dynamic', 'Penultimate', 'Unbothered', 'Stoic', 'Unregulated', ];
const List<String> nouns = ['Firefighter', 'Lavalamp', 'Practitioner', 'Olive', 'Haberdasher', "Larynx"];

class NameEngine {
  NameEngine._();

  static String get _adjective => adjectives[Random().nextInt(adjectives.length)];
  static String get _noun => nouns[Random().nextInt(nouns.length)];

  static String get userName => _adjective + _noun;
}
