import 'package:flutter/material.dart';
import 'package:flutter_project/component/navigator_to_login_screen.dart';
import 'package:flutter_project/component/navigator_to_register_screen.dart';
import 'package:flutter_project/const/app_text.dart';
import 'package:flutter_project/const/form_space.dart';
import 'package:flutter_project/const/style_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(welcomeText, style: title2)),
            SizedBox(height: formSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [NavigatorToLoginScreen(), NavigatorToRegisterScreen()],
            ),
          ],
        ),
      ),
    );
  }
}
