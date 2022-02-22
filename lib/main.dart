// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}



class _RandomWordsState extends State<RandomWords> {
  //list of wordpair
  final _suggestions = <WordPair>[];
  //debugPrint("Display suggeestions[] : " + _suggestions.toString());

  //to save favorite wordpair
  final _saved = <WordPair>{};
  //debugPrint("Display saved{} : " + _saved.toString());

  //style font object
 final _biggerFont = const TextStyle(color: Color(0xFF426894), fontSize: 18);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
        ),
        //listview for wordpair
        body: ListView.builder(
            padding: const EdgeInsets.all(16.0),

            itemBuilder: (context, i) {
              //return divider if i is impair
              if (i.isOdd) return const Divider();

              //return result of i division by 2 in enter
              final index = i ~/ 2;


              if (index >= _suggestions.length) {
                  _suggestions.addAll(generateWordPairs().take(10));
              }

              final alreadySaved = _saved.contains(_suggestions[index]);

              //debugPrint("Display already saved" + alreadySaved.toString());
              return ListTile(
                title: Text (_suggestions[index].asPascalCase,
                            style: _biggerFont,
                            ),
                trailing: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
                  color: alreadySaved ? Colors.red : null,
                ),
                onTap: () {      // NEW lines from here...
                  setState(() {
                    if (alreadySaved) {
                      _saved.remove(_suggestions[index]);
                    }
                    else {
                      _saved.add(_suggestions[index]);
                    }
                  });
                },
              );

            }
        ));
  }
}
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}
