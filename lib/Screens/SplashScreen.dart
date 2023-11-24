import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wechat/SplashScreen/SplashToFirstScreen.dart';
import 'package:wechat/Themes/constants.dart';



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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashScreenToFirst(),));
    });

  }

  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        // const RiveAnimation.asset(
        //   'images/message_icon.riv',
        //   fit: BoxFit.cover,
        // ),
        Container(
            color: kPrimaryColor,
            child: Center(
                child: Lottie.asset(
                    "animation/chat_icon.json"))),
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
