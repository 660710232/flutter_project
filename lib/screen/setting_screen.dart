import 'package:flutter/material.dart';
import 'package:flutter_project/const/form_space.dart';
import 'package:flutter_project/const/style_theme.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  final String username;

  const SettingsScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [

         Text(
            "Account",
            style: body2,
          ),

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
          Text(
            "Appearance",
            style: body2,
          ),

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

          // ===== Action Section =====
          Text(
            "Action",
            style: body2,
          ),

          SizedBox(height: formSpace),

          Card(
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: body1,),
              onTap: () {

                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}