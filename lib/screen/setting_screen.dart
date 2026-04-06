import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/const/form_space.dart';
import 'package:flutter_project/const/style_theme.dart';
import 'package:flutter_project/main.dart';

class SettingScreen extends StatefulWidget {
  final String username;
  const SettingScreen({super.key, required this.username});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String get username => widget.username;
  Map<String, int> bookStat = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadStats();
  }

  void loadStats() async {
    bookStat = await getStats(username);
    setState(() {});
  }

  Future<Map<String, int>> getStats(String username) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('username', isEqualTo: username)
        .get();

    int unread = 0;
    int reading = 0;
    int read = 0;

    for (var doc in snapshot.docs) {
      String status = doc['read'];

      if (status == 'Unread') {
        unread++;
      } else if (status == 'Reading') {
        reading++;
      } else if (status == 'Read') {
        read++;
      }
    }

    return {'unread': unread, 'reading': reading, 'read': read};
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("Account", style: body2),

          SizedBox(height: formSpace),

          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text("Username", style: body1),
              subtitle: Text(username, style: body1),
            ),
          ),

          SizedBox(height: formSpace),

          // ===== Appearance Section =====
          Text("Appearance", style: body2),

          SizedBox(height: formSpace),

          Card(
            child: ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Dark Mode", style: body1),
              trailing: Switch(
                value: !isLight,
                onChanged: (value) {
                  MainWidget.of(context)?.toggleMode();
                },
              ),
            ),
          ),

          SizedBox(height: formSpace),


          Text("Appearance", style: body2),
          SizedBox(height: formSpace),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.my_library_books),
                  title: Text("Unread Book Total", style: body1),
                  subtitle: Text('${bookStat['unread']}', style: body1),
                ),
                ListTile(
                  leading: Icon(Icons.my_library_books),
                  title: Text("Now Reading Book", style: body1),
                  subtitle: Text('${bookStat['reading']}', style: body1),
                ),
                ListTile(
                  leading: Icon(Icons.my_library_books),
                  title: Text("Read Book Total", style: body1),
                  subtitle: Text('${bookStat['read']}', style: body1),
                ),
              ],
            ),
          ),

          SizedBox(height: formSpace),

          // ===== Action Section =====
          Text("Action", style: body2),

          SizedBox(height: formSpace),

          Card(
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: body1),
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }
}
