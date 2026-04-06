import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/model/books.dart';

class DbBookService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addBooks(Book book) async {
    await _db.collection('books').add(book.toJson());
    print('add success');
  }

  Future<void> updateBookStatusByTitle(
    String title, String username, String newStatus) async {

  final snapshot = await FirebaseFirestore.instance
      .collection('books')
      .where('title', isEqualTo: title)
      .where('username', isEqualTo: username) // สำคัญมาก!
      .get();

  for (var doc in snapshot.docs) {
    await doc.reference.update({'read': newStatus});
  }
}
}
