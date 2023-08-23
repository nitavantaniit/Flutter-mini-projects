import 'package:dictionaryapp/Database/database.dart';
import 'package:flutter/material.dart';

class EditWordScreen extends StatefulWidget {
  final int wordId;

  EditWordScreen({required this.wordId});

  @override
  _EditWordScreenState createState() => _EditWordScreenState();
}

class _EditWordScreenState extends State<EditWordScreen> {
  TextEditingController _wordController = TextEditingController();
  TextEditingController _meaningController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWordData();
  }

  Future<void> _loadWordData() async {
    Map<String, dynamic> wordMap = await DatabaseHelper.instance.getWordById(widget.wordId);
    _wordController.text = wordMap['word'];
    _meaningController.text = wordMap['meaning'];
    _descriptionController.text = wordMap['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Word'), backgroundColor: Colors.blue[900],),
      backgroundColor: Colors.black,
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
                children: <Widget>[
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
                      await _editWord();
                      Navigator.pop(context);
                    },
                    child: Text('Save Changes'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editWord() async {
    String newWord = _wordController.text;
    String newMeaning = _meaningController.text;
    String newDescription = _descriptionController.text;

    if (newWord.isNotEmpty && newMeaning.isNotEmpty) {
      Map<String, dynamic> updatedWordMap = {
        'word': newWord,
        'meaning': newMeaning,
        'description': newDescription,
      };
      await DatabaseHelper.instance.editWord(widget.wordId, updatedWordMap);
    }
  }
}

