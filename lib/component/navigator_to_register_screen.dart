import 'package:flutter/material.dart';
import 'package:flutter_project/const/style_theme.dart';
import 'package:flutter_project/screen/register_screen.dart';

class NavigatorToRegisterScreen extends StatefulWidget {
  const NavigatorToRegisterScreen({super.key});

  @override
  State<NavigatorToRegisterScreen> createState() =>
      _NavigatorToRegisterScreenState();
}

class _NavigatorToRegisterScreenState extends State<NavigatorToRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen()),
        );
      },
      child: Text(
        'You don\'t have account?',
        style: button1.copyWith(fontSize: 12, fontStyle: FontStyle.italic),
      ),
    );
  }
}
