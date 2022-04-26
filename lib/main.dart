import 'package:flutter/material.dart';

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

  List<String> words = ["dancer", "mouse", "button", "jazz", "cat"];

  String pickRandomWord() {
    words.shuffle();
    return words[0];
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
              padding: EdgeInsets.all(16), 
              decoration: BoxDecoration(
                border: Border.all()
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
