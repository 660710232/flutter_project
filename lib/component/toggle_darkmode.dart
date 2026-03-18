import 'package:flutter/material.dart';

class ToggleDarkmode extends StatelessWidget {
  final VoidCallback toggleMode;
  const ToggleDarkmode({super.key, required this.toggleMode});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: toggleMode, icon: Icon(Icons.switch_left));
  }
}