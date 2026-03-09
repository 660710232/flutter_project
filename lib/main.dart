import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/const/color_theme.dart';
import 'package:flutter_project/firebase_options.dart';
import 'package:flutter_project/screen/login_screen1.dart';
import 'package:flutter_project/screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainWidget());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Library',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(colorScheme: .fromSeed(seedColor: secondaryColor)),
//       home: WelcomeScreen(username: "Tenergyz"),
//     );
//   }
// }

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  bool isLightMode = true;

  void toggleMode() {
    setState(() {
      isLightMode = !isLightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library of Dream',
      debugShowCheckedModeBanner: false,
      theme: isLightMode
          ? ThemeData.light().copyWith(scaffoldBackgroundColor: mainColor)
          : ThemeData.dark().copyWith(scaffoldBackgroundColor: darkMainColor),
      themeMode: ThemeMode.system,
      home: LoginScreen(),
    );
  }
}
