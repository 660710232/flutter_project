import 'package:flutter/material.dart';
import 'package:flutter_project/const/style_theme.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback toggleMode;
  final String username;
  const WelcomeScreen({super.key, required this.username, required this.toggleMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: toggleMode, icon: Icon(Icons.switch_left))],
      ),
      body: Center(child: Text("สวัสดี, $username", style: title1)),
    );
  }
}
