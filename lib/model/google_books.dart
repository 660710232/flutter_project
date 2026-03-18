class GoogleBook {
  final String title;
  final String author;
  final String thumbnail;

  GoogleBook({
    required this.title,
    required this.author,
    required this.thumbnail,
  });

  factory GoogleBook.fromJson(Map<String, dynamic> json) {
    var info = json['volumeInfo'];

    return GoogleBook(
      title: info['title'] ?? 'No Title',
      author: (info['authors'] != null)
          ? info['authors'][0]
          : 'Unknown Author',
      thumbnail: (info['imageLinks'] != null)
          ? info['imageLinks']['thumbnail']
          : '',
    );
  }
}