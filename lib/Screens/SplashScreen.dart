import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart' hide RadialGradient;


import 'Message/PersonalMessageScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PersonalMessageScreen(),));
    });

  }

  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        const RiveAnimation.asset(
          'images/message_icon.riv',
          fit: BoxFit.cover,
        ),
        Center(
          child: SizedBox(
            child: Material(
              type: MaterialType.transparency,
                child: Container(
                  margin: const EdgeInsets.only(top: 350,),
                  child: const Text("WeChat",
                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,letterSpacing: 2),
                  ),
                )),
          ),
        )
      ],
    );
  }
}
