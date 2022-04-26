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
  final submitField = TextEditingController();

  int mistakes = 0;
  int maxMistakes = 6;
  String? secretWord;
  List<String> missedChars = [];

  void submitChar(char) {
    if(false) {

    }
    else if(!missedChars.contains(char)) {
      setState(() {
        mistakes += 1;
        missedChars.add(char);
        submitField.clear();
      });
    }
    else {
      submitField.clear();
    }
  }

  @override
  void initState() {
    words.shuffle();
    secretWord = words[0];
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
            children: [
              Row(
                children: secretWord!.split('').map((char) => Container(
                  padding: EdgeInsets.all(16), 
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                )).toList(),
              ),
              SizedBox(width: 16),
              Text(
                "${mistakes} / ${maxMistakes}",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            children: missedChars.map((char) => Container(
              padding: EdgeInsets.all(8),
              child: Text(
                char,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
