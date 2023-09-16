import 'package:dictionaryapp/Database/database.dart';
import 'package:dictionaryapp/Models/users.dart';
import 'package:dictionaryapp/add_word.dart';
import 'package:dictionaryapp/edit_word.dart';
import 'package:dictionaryapp/word_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Word> words = [];
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Dictionary'),
        backgroundColor: Colors.red[900],
        leading: Icon(Icons.book),
      ),
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Search words below',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                        hintText: 'Search words in Google...',
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
            SizedBox(height: 10),
            Image.asset('assets/images/dictionary.png'),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'My Words (Tap on the Words to see Meaning and Description )',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: words.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                int id = words[index].id;
                String word = words[index].word;
                return Dismissible(
                  key: Key('$id'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return _showDeleteConfirmationDialog(context, id);
                  },
                  onDismissed: (direction) async {
                    await _deleteWord(id);
                  },
                  child: GestureDetector(
                    onTap: () {
                      _navigateToWordDetailScreen(context, word);
                    },
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              word,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blueAccent,),
                            onPressed: () {
                              _navigateToEditWordScreen(context, id);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent,),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: !_isSearching,
        child: FloatingActionButton(
          onPressed: () async {
            await _navigateToAddWordScreen(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red[900],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context, int id) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Word'),
          content: Text('Are you sure you want to delete this word?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteWord(id);
                Navigator.of(context).pop(true);
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

  void _showPopupMenu(BuildContext context, int id) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: Text('Edit'),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
    ).then((value) {
      if (value == 'edit') {
        _navigateToEditWordScreen(context, id);
      } else if (value == 'delete') {
        _showDeleteConfirmationDialog(context, id);
      }
    });
  }

  Future<void> _navigateToWordDetailScreen(BuildContext context, String word) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WordDetailScreen(word: word),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
