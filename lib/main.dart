import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MaterialApp(
    home: Hangman(),
  ));
}

class Hangman extends StatefulWidget {
  @override
  State<Hangman> createState() => _HangmanState();
}

class _HangmanState extends State<Hangman> {
  final submitField = TextEditingController();

  bool gameEnded = false;
  bool lost = false;

  int mistakes = 0;
  int maxMistakes = 6;
  String secretWord = "";
  String guessedWord = "";
  List<String> missedChars = [];

  void playAgain() {
    setState(() {
      mistakes = 0;
      missedChars = [];
      pickRandomWord();
    });
  }

  void submitChar(String char) {
    try {
      setState(() {
        if (char == "") {
          return;
        }

        submitField.clear();

        if (secretWord.contains(char)) {
          for (int i = 0; i < secretWord.length; i++) {
            if (secretWord[i] == char) {
              guessedWord = guessedWord.substring(0, i) +
                  char +
                  guessedWord.substring(i + 1);
            }
          }

          if (secretWord == guessedWord) {
            gameEnded = true;
            lost = false;
          }
        } else if (!missedChars.contains(char)) {
          mistakes += 1;
          missedChars.add(char);

          if (mistakes >= maxMistakes) {
            guessedWord = secretWord;
            gameEnded = true;
            lost = true;
          }
        }
      });
    }
    // Makes it work somehow i guess ¯\_(ツ)_/¯
    on PlatformException catch (err) {}
  }

  void pickRandomWord() {
    lost = false;
    gameEnded = false;

    int index = Random().nextInt(nouns.length);
    secretWord = nouns[index];
    guessedWord = "";
    secretWord.split('').forEach((element) {
      guessedWord += "-";
    });
  }

  @override
  void initState() {
    pickRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hangman"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            enabled: !gameEnded,
            controller: submitField,
            onSubmitted: submitChar,
            onEditingComplete: () {},
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: guessedWord
                .split('')
                .map((char) => Container(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        char,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      decoration: BoxDecoration(border: Border.all()),
                    ))
                .toList(),
          ),
          SizedBox(height: 16),
          Wrap(
            children: missedChars
                .map((char) => Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        char,
                        style: TextStyle(
                          fontSize: 22,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: playAgain,
                child: Text("Continu"),
              ),
              SizedBox(width: 32),
              Icon(
                Icons.error,
                color: gameEnded
                    ? (lost ? Colors.red : Colors.green)
                    : Colors.black,
              ),
              SizedBox(width: 4),
              Text(
                "${mistakes} / ${maxMistakes}",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
