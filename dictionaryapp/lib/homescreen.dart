import 'package:dictionaryapp/Database/database.dart';
import 'package:dictionaryapp/Models/users.dart';
import 'package:dictionaryapp/add_word.dart';
import 'package:dictionaryapp/edit_word.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Word> words = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future<void> _loadWords() async {
    List<Map<String, dynamic>> wordMaps = await DatabaseHelper.instance.getAllWords();
    words = wordMaps.map((wordMap) => Word.fromMap(wordMap)).toList();
    setState(() {});
  }

  Future<void> _navigateToAddWordScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddWordScreen(),
      ),
    );
    _loadWords();
  }

  Future<void> _navigateToEditWordScreen(BuildContext context, int id) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditWordScreen(wordId: id),
      ),
    );
    _loadWords();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, int id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Word'),
          content: Text('Are you sure you want to delete this word?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteWord(id);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteWord(int id) async {
    await DatabaseHelper.instance.deleteWord(id);
    _loadWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Dictionary'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Search Words',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search word...',
                        hintStyle: TextStyle(color: Colors.black87),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      String wordToSearch = Uri.encodeComponent(_searchController.text);
                      String url = 'https://www.google.com/search?q=$wordToSearch';
                      _launchURL(url);
                    },
                    child: Text('Search', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: words.length + 1,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'My Words',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    );
                  }
                  int id = words[index - 1].id;
                  String word = words[index - 1].word;
                  String meaning = words[index - 1].meaning;
                  String description = words[index - 1].description;
                  return Container(
                    color: Colors.white, 
                    child: ListTile(
                      title: Text(word, style: TextStyle(color: Colors.black)), 
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Meaning: $meaning', style: TextStyle(color: Colors.black)), 
                          Text('Description: $description', style: TextStyle(color: Colors.black)), 
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () {
                              _navigateToEditWordScreen(context, id);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, id);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        String wordToSearch = Uri.encodeComponent(word);
                        String url = 'https://www.google.com/search?q=$wordToSearch';
                        _launchURL(url);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _navigateToAddWordScreen(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
