import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/component/navigator_to_register_screen.dart';
import 'package:flutter_project/const/color_theme.dart';
import 'package:flutter_project/const/form_space.dart';
import 'package:flutter_project/const/style_theme.dart';
import 'package:flutter_project/const/app_text.dart';
import 'package:flutter_project/screen/home_screen.dart';
import 'package:flutter_project/screen/library_screen.dart';
import 'package:flutter_project/screen/register_screen.dart';
import 'package:flutter_project/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String textError = '';
  bool passwordVisible = true;

  void triggerPasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  Future<String> getUsername(String email) async {
  var result = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();

  return result.docs.first['username'];
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          width: 400,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(appName, style: title1),
                SizedBox(height: 5),
                Text(textError, style: errorlogin),
                SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: formSpace),
                TextFormField(
                  controller: _passwordController,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          triggerPasswordVisible();
                        });
                      },
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: formSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NavigatorToRegisterScreen(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: foregroundColorButton,
                        backgroundColor: backgroundColorButton,
                        textStyle: button1,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          AuthService auth = AuthService();
                          bool success = await auth.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (success){
                            print('success');
                            String username = await getUsername(_emailController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(username: username),
                              ),
                            );
                          } else {
                            setState(() {
                              textError = 'Email or Password Incorrect';
                            });
                            print('Email or password incorrect');
                          }
                        } else {
                          print('form invalid');
                        }
                      },
                      child: Text('Login', style: button1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
