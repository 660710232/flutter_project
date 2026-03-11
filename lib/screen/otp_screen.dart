import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/const/form_space.dart';
import 'package:flutter_project/screen/login_screen.dart';
import 'package:flutter_project/services/auth_service.dart';

class OtpScreen extends StatefulWidget {
  final String username;
  final String password;
  final String name;
  final String lastname;
  final String email;
  const OtpScreen({
    super.key,
    required this.username,
    required this.password,
    required this.name,
    required this.lastname,
    required this.email,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                TextFormField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    labelText: 'OTP',
                    border: OutlineInputBorder(),
                    hintText: 'Enter OTP',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter OTP';
                    }
                    return null;
                  },
                ),
                SizedBox(height: formSpace),
                ElevatedButton(
                  onPressed: () async {
                    bool verify = EmailOTP.verifyOTP(otp: _otpController.text);
                    if (verify) {
                      AuthService auth = AuthService();
                      await auth.setUser(
                        widget.username,
                        widget.password,
                        widget.name,
                        widget.lastname,
                        widget.email,
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  },
                  child: Text('Verify'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
