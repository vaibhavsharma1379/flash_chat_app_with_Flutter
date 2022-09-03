import 'package:flash_chat/screens/logIn_sreen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'components/input_button.dart';
import 'package:firebase_core/firebase_core.dart';

class WelcomScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomScreen({Key? key}) : super(key: key);

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                      child: Image.asset('images/logo.png'), height: 60),
                ),
              ),
              AnimatedTextKit(animatedTexts: [
                TypewriterAnimatedText(
                  'Flash Chat',
                  speed: Duration(milliseconds: 300),
                  textStyle: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                  ),
                )
              ])
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InputButton(
            ButtonText: 'Log In',
            onPressed: () async {
              await Firebase.initializeApp();
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
          SizedBox(
            height: 48,
          ),
          InputButton(
            ButtonText: 'Registor',
            onPressed: () async {
              await Firebase.initializeApp();
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
          )
        ],
      ),
    );
  }
}
