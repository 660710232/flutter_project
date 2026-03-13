import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/model/books.dart';

class FilterBookService {
  String username;
  FilterBookService({required this.username});

  Future<List<Book>> getUserBooks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('username', isEqualTo: username)
        .get();

    return snapshot.docs
        .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Book>> getReadUserBooks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('username', isEqualTo: username).where('read', isEqualTo: 'Read')
        .get();

    return snapshot.docs
        .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Book>> getUnreadUserBooks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('username', isEqualTo: username).where('read', isEqualTo: 'Unread')
        .get();

    return snapshot.docs
        .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Book>> getReadingUserBooks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('username', isEqualTo: username).where('read', isEqualTo: 'Reading')
        .get();

    return snapshot.docs
        .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
