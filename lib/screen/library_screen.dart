import 'package:flutter/material.dart';
import 'package:flutter_project/const/form_space.dart';
import 'package:flutter_project/const/style_theme.dart';
import 'package:flutter_project/model/books.dart';
import 'package:flutter_project/services/db_book_service.dart';
import 'package:flutter_project/services/filter_book_service.dart';

class LibraryScreen extends StatefulWidget {
  final String username;
  const LibraryScreen({super.key, required this.username});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String? _selectedItem = 'All Book';
  String get username => widget.username;
  List<Book> bookUser = [];

  @override
  void initState() {
    super.initState();
    filterSelectedItem();
  }

  void filterSelectedItem() async {
    FilterBookService filter = FilterBookService(username: username);

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

  Color getStatusColor(String status) {
    if (status == 'Read') return Colors.green;
    if (status == 'Reading') return Colors.orange;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: formSpace),

          // 🔽 FILTER DROPDOWN
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              value: _selectedItem,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              items: ['All Book', 'Unread', 'Reading', 'Read']
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Center(child: Text(item, style: body1)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                _selectedItem = value;
                filterSelectedItem();
              },
            ),
          ),

          SizedBox(height: formSpace),

          // 📚 BOOK LIST / EMPTY
          Expanded(
            child: bookUser.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_book,
                            size: 80, color: Colors.grey.shade400),
                        const SizedBox(height: 10),
                        Text(
                          "ไม่มีหนังสือในห้องสมุดของคุณ",
                          style: body1.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: bookUser.length,
                    itemBuilder: (context, index) {
                      Book book = bookUser[index];

                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),

                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: const Icon(Icons.menu_book,
                                color: Colors.blue),
                          ),

                          title: Text(
                            book.title,
                            style: body1.copyWith(
                                fontWeight: FontWeight.bold),
                          ),

                          subtitle: Text(book.author),

                          trailing: DropdownButton<String>(
                            value: ['Unread', 'Reading', 'Read']
                                    .contains(book.read)
                                ? book.read
                                : 'Unread',
                            underline: const SizedBox(),

                            items: ['Unread', 'Reading', 'Read']
                                .map(
                                  (status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        color: getStatusColor(status),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),

                            onChanged: (value) async {
                              if (value == null) return;

                              await DbBookService()
                                  .updateBookStatusByTitle(
                                book.title,
                                username,
                                value,
                              );

                              setState(() {
                                book.read = value;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 8),
                  ),
          ),
        ],
      ),
    );
  }
}