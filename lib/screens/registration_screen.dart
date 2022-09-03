import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'components/input_button.dart';
import 'components/input_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'static_screen';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool show_progress = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: show_progress,
        child: Padding(
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
                  email = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              InputField(
                'Enter Your Password',
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              InputButton(
                  ButtonText: 'Registration',
                  onPressed: () async {
                    setState(() {
                      show_progress = true;
                    });
                    try {
                      final new_user =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (new_user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        show_progress = false;
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
