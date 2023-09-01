import 'package:dictionaryapp/Database/database.dart';
import 'package:flutter/material.dart';

class WordDetailScreen extends StatelessWidget {
  final String word;

  WordDetailScreen({required this.word});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(word),
        backgroundColor: Colors.red[900],
      ),
      backgroundColor: Colors.blueGrey[100],
      body: FutureBuilder(
        future: DatabaseHelper.instance.getWordByWord(word),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No data available.'));
          }
          Map<String, dynamic> wordData = snapshot.data as Map<String, dynamic>;
          String meaning = wordData['meaning'];
          String description = wordData['description'];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Meaning: $meaning', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Description: $description', style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
