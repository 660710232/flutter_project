import 'package:flutter/material.dart';
import 'package:flutter_project/screen/setting_screen.dart';
import 'library_screen.dart';
import 'add_book_screen.dart';


class HomeScreen extends StatefulWidget {

  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      LibraryScreen(username: widget.username),
      AddBookScreen(username: widget.username),
      SettingsScreen(username: widget.username),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "Library",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),

        ],
      ),
    );
  }
}