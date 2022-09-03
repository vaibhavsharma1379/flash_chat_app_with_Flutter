import 'package:flutter/material.dart';
import 'package:flash_chat/screens/logIn_sreen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/WelcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const flashChat());
}

class flashChat extends StatelessWidget {
  const flashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: WelcomScreen.id,
      routes: {
        WelcomScreen.id: (context) => WelcomScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen()
      },
    );
  }
}
