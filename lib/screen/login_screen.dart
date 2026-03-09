import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/const/color_theme.dart';
import 'package:flutter_project/const/form_space.dart';
import 'package:flutter_project/const/style_theme.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String textError = '';
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'Users',
  );
  bool passwordVisible = false;

  void triggerPasswordVisible() {
    passwordVisible = !passwordVisible;
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
                Text('Login to your Library', style: title1),
                SizedBox(height: 5),
                Text(textError, style: errorlogin),
                SizedBox(height: 30),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Username',
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'You don\'t have account?',
                        style: button1.copyWith(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
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
                            _usernameController.text,
                            _passwordController.text,
                          );

                          if (success) {
                            print('success');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LibraryScreen(),
                              ),
                            );
                          } else {
                            setState(() {
                              textError = 'Username or Password Incorrect';
                            });
                            print('Username or password incorrect');
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
