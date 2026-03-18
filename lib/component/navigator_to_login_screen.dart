import 'package:flutter/material.dart';
import 'package:flutter_project/const/style_theme.dart';
import 'package:flutter_project/screen/login_screen.dart';

class NavigatorToLoginScreen extends StatefulWidget {
  const NavigatorToLoginScreen({super.key});

  @override
  State<NavigatorToLoginScreen> createState() => _NavigatorToLoginScreenState();
}

class _NavigatorToLoginScreenState extends State<NavigatorToLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Text(
        'I have account',
        style: button1.copyWith(fontSize: 12, fontStyle: FontStyle.italic),
      ),
    );
  }
}
