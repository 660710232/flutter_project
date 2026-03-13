import 'package:flutter/material.dart';
import 'package:flutter_project/const/color_theme.dart';
import 'package:flutter_project/const/form_space.dart';
import 'package:flutter_project/model/books.dart';
import 'package:flutter_project/services/filter_book_service.dart';

class LibraryScreen extends StatefulWidget {
  final String username;
  const LibraryScreen({super.key, required this.username});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedItem = 'All Book';
  String get username => widget.username;
  List<Book> bookUser = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      filterSelectedItem();
    });
  }

  void filterSelectedItem() async {
    FilterBookService filter = FilterBookService(username: username);
    // print(_selectedItem);
    List<Book> bookUserFilter = [];
    if (_selectedItem == 'All Book') {
      bookUserFilter = await filter.getUserBooks();
    } else if (_selectedItem == 'Unread') {
      bookUserFilter = await filter.getUnreadUserBooks();
    } else if (_selectedItem == 'Reading') {
      bookUserFilter = await filter.getReadingUserBooks();
    } else if (_selectedItem == 'Read') {
      bookUserFilter = await filter.getReadUserBooks();
    }

    setState(() {
      bookUser = bookUserFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(username),

          Container(
            height: 50,
            width: 120,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedItem,
              items: ['All Book', 'Unread', 'Reading', 'Read']
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Center(child: Text(item)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                  _selectedItem = value;
                  filterSelectedItem();              },
            ),
          ),
          SizedBox(height: formSpace),
          Expanded(
            child: ListView.separated(
              itemCount: bookUser.length,
              itemBuilder: (context, index) {
                Book book = bookUser[index];

                return ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  trailing: Text(book.read),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}
