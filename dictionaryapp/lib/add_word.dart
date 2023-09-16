import 'package:dictionaryapp/Database/database.dart';
import 'package:flutter/material.dart';

class AddWordScreen extends StatefulWidget {
  const AddWordScreen({super.key});

  @override
  _AddWordScreenState createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  TextEditingController _wordController = TextEditingController();
  TextEditingController _meaningController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Word'), backgroundColor: Colors.red[900],),
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _wordController,
                    decoration: InputDecoration(labelText: 'Word'),
                  ),
                  TextField(
                    controller: _meaningController,
                    decoration: InputDecoration(labelText: 'Meaning'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _addWord();
                      Navigator.pop(context);
                    },
                    child: Text('Add Word'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addWord() async {
    String word = _wordController.text;
    String meaning = _meaningController.text;
    String description = _descriptionController.text;

    if (word.isNotEmpty && meaning.isNotEmpty) {
      Map<String, dynamic> wordMap = {
        'word': word,
        'meaning': meaning,
        'description': description,
      };
      await DatabaseHelper.instance.insertWord(wordMap);
    }
  }
}

