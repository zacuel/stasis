import 'dart:math';

const List<String> adjectives = [
  'Absolute',
  'Dynamic',
  'Penultimate',
  'Unbothered',
  'Stoic',
  'Unregulated',
  'Abstract',
  'Unique',
  'Venomous',
  'Unglued',
  "Incoherant",
  "Indignant",
  "Charming",
  "Convoluted",
  "Synchronized",
  "Chronological",
  "Shenanigan",
  "Placebo",
  "Dinosaur",
  "Berry",
  "Fanfaction",
  "Vigilant",
  "Standoffish",
  "Flying",
  "Dastardly",
  "Indignant",
  "Curious",
  "Distilled",
  "Harmonious",
  "Esoteric",
  "Ambient",
];
const List<String> nouns = [
  'Firefighter',
  'Lavalamp',
  'Practitioner',
  'Olive',
  'Haberdasher',
  "Larynx",
  "Allegory",
  "Werewolf",
  "Underdog",
  "Introspection",
  "Phoenician",
  "Antagonist",
  "Metaphor",
  "Sabotage",
  "Alibi",
  "Continuum",
  "Conduit",
  "Shindig",
  "Mccoy",
  "Shoehorn",
  "Avalanche",
  "Zebrafish",
  "Ducttape",
  "Simplicity",
  "Mastermind",
  "Entropy",
];

class NameEngine {
  NameEngine._();

  static String get _adjective => adjectives[Random().nextInt(adjectives.length)];
  static String get _noun => nouns[Random().nextInt(nouns.length)];

  static String get userName => _adjective + _noun;
}
