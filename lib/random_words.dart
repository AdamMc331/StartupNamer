import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  /// Builds a list of suggested word pairings in a ListView.
  ///
  /// The itemBuilder callback is called once per suggested
  /// word pairing, and places each suggestion into a ListTile row.
  /// For even rows, the function adds a ListTile row for the word pairing.
  /// For odd rows, the function adds a Divider widget to visually separate the entries.
  /// Note that the divider may be difficult to see on smaller defices.
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();
        // The syntax "index ~/ 2" divides i by 2 and returns an integer result.
        // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
        // This calculates the actual number of word pairings in the ListView, minus divider widgets.
        final index = i ~/ 2;

        // If we've reached the end of word pairings, generate 10 more
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  /// Builds a ListTile for an individual WordPair row.
  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Startup Name Generator"),
      ),
      body: _buildSuggestions(),
    );
  }
}
