class Word {
  final int id;
  final String word;
  final String meaning;
  final String description;

  Word({
    required this.id,
    required this.word,
    required this.meaning,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'meaning': meaning,
      'description': description,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'],
      word: map['word'],
      meaning: map['meaning'],
      description: map['description'],
    );
  }
}
