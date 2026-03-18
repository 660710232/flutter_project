import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/model/books.dart';

class DbBookService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addBooks(Book book) async {
    await _db.collection('books').add(book.toJson());
    print('add success');
  }
}
