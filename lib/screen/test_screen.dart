import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/books.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('books').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final books = snapshot.data!.docs
            .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return ListView.separated(
          itemCount: books.length,

          itemBuilder: (context, index) {
            Book book = books[index];

            return ListTile(
              leading: const Icon(Icons.menu_book),
              title: Text(book.title),
              subtitle: Text(book.author),
              
              );
          },

          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      },
    );
  }
}
