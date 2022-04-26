import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
      home: Hangman(),
    )
  );
}

class Hangman extends StatefulWidget {
  @override
  State<Hangman> createState() => _HangmanState();
}

class _HangmanState extends State<Hangman> {

  final List<String> words = ["dancer", "mouse", "button", "jazz", "cat"];

  String? secretWord;
  List<String> missedChars = [];

  String pickRandomWord() {
    words.shuffle();
    secretWord = words[0];
    return secretWord!;
  }

  void submitChar(char) {
    setState(() {
      missedChars.add(char);
    });
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
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pickRandomWord().split('').map((char) => Container(
              padding: EdgeInsets.all(24), 
              decoration: BoxDecoration(
                border: Border.all()
              ),
            )).toList(),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: missedChars.map((char) => Container(
              padding: EdgeInsets.all(8),
              child: Text(
                char,
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            )).toList(),
          ),
          SizedBox(height: 24),
          TextField(
            onSubmitted: submitChar,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
