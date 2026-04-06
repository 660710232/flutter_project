import 'package:flutter/material.dart';
import 'package:flutter_project/const/form_space.dart';
import 'package:flutter_project/model/books.dart';
import 'package:flutter_project/model/google_books.dart';
import 'package:flutter_project/services/db_book_service.dart';
import '../services/google_book_service.dart';

class AddBookScreen extends StatefulWidget {
  final String username;
  const AddBookScreen({super.key, required this.username});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  TextEditingController searchController = TextEditingController();
  String get username => widget.username;
  List<GoogleBook> searchBooks = [];
  final _formKey = GlobalKey<FormState>();

  void searchBook() async {
    GoogleBookService service = GoogleBookService();

    List<GoogleBook> result = await service.searchBooks(searchController.text);

    setState(() {
      searchBooks = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(formSpace),
            width: 420,
            height: 40,
            decoration: BoxDecoration(
              // color: secondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SizedBox(height: 30,),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Book Title : กาสักอังก์ฆาต",
                        labelText: 'Search book',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Book Title';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      searchBook();
                    }
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: searchBooks.length,

              itemBuilder: (context, index) {
                GoogleBook book = searchBooks[index];

                return ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: Text(book.title),
                  subtitle: Text(book.author),

                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      // print("Add ${book.title}");
                      DbBookService dbBook = DbBookService();
                      await dbBook.addBooks(
                        Book(book.title, book.author, 'Unread', username),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Book Added")),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
