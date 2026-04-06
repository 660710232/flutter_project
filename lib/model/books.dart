class Book {
  final String title;
  final String author;
  String read;
  final String username;

  Book(this.title, this.author, this.read, this.username);

  Book.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      author = json['author'],
      read = json['read'],
      username = json['username'];

  Map<String, dynamic> toJson() {
    return {'title': title, 'author': author, 'read': read, 'username':username};
  }
}
