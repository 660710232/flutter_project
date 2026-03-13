import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/const/color_theme.dart';
import 'package:flutter_project/firebase_options.dart';
import 'package:flutter_project/screen/library_screen.dart';
import 'package:flutter_project/screen/login_screen.dart';
import 'package:flutter_project/screen/test_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EmailOTP.config(
    appEmail: "libraryofdream.app@gmail.com",
    appName: "Library Of Dream",
    otpType: OTPType.numeric,
    otpLength: 6,
    emailTheme: EmailTheme.v4,
    expiry: 30000,

  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
