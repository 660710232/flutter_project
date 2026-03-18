import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/google_books.dart';

class GoogleBookService {

  Future<List<GoogleBook>> searchBooks(String query) async {

    final url = Uri.parse(
      "https://www.googleapis.com/books/v1/volumes?q=$query",
    );

    final response = await http.get(url);

    final data = json.decode(response.body);

    List items = data['items'];

    return items.map((e) => GoogleBook.fromJson(e)).toList();
  }
}