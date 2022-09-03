import 'package:flash_chat/screens/chat_screen.dart';
import 'components/input_text.dart';
import 'package:flutter/material.dart';
import 'components/input_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late var Email;
  late var Password;
  bool showProgressCircle = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showProgressCircle,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset(
                      'images/logo.png',
                      height: 300,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              InputField(
                'Enter Your Email',
                onChanged: (value) {
                  Email = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              InputField(
                'Enter Your Password',
                obscureText: true,
                onChanged: (value) {
                  Password = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              InputButton(
                  ButtonText: 'LogIn',
                  onPressed: () async {
                    setState(() {
                      showProgressCircle = true;
                    });
                    print(Email + Password);
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: Email, password: Password);

                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showProgressCircle = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
