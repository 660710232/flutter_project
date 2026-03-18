import 'package:flutter/material.dart';
import 'package:flutter_project/component/navigator_to_login_screen.dart';
import 'package:flutter_project/const/color_theme.dart';
import 'package:flutter_project/const/form_space.dart';
import 'package:flutter_project/const/style_theme.dart';
import 'package:flutter_project/screen/login_screen.dart';
import 'package:flutter_project/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool passwordVisible = true;
  String textError = '';
  bool registerClick = false;

  void triggerPasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
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
                Text('Create your Library', style: title1),
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
                      return 'Please Enter Username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: formSpace),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Email : example@gmail.com',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    }

                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Invalid Email Format";
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
                      return 'Please Enter Password';
                    }
                    if (value.length < 8) {
                      return 'password must have at at least 8 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: formSpace),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Confirm Password',
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
                      return 'Please Enter Confirm Password';
                    } else if (_confirmPasswordController.text !=
                        _passwordController.text) {
                      return 'Confirm Password is not match!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: formSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NavigatorToLoginScreen(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: foregroundColorButton,
                        backgroundColor: backgroundColorButton,
                        textStyle: button1,
                      ),
                      onPressed: registerClick
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  registerClick = true;
                                });
                                AuthService auth = AuthService();
                                bool userAvai = await auth.checkUserAvailable(
                                  _usernameController.text,
                                );

                                bool emailAvai = await auth.checkEmailAvailable(
                                  _emailController.text,
                                );

                                if (userAvai && emailAvai) {
                                  bool register = await auth.register(
                                    _usernameController.text,
                                    _emailController.text.trim(),
                                    _passwordController.text,
                                  );
                                  if (register) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  }
                                } else {
                                  setState(() {
                                    textError =
                                        'This username or email has already been used.';
                                  });
                                }
                              }
                            },
                      child: Text('Register', style: button1),
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
