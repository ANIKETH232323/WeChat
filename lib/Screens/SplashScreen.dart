import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:wechat/SplashScreen/AppBarBody/MessageToHomeScreen.dart';
import 'package:wechat/SplashScreen/landing_page.dart';
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
    Timer(const Duration(seconds: 3), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.black));
      if(FirebaseAuth.instance.currentUser != null){
        log('\nuser:${FirebaseAuth.instance.currentUser}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Landing_Page(),));
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
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
                  margin: const EdgeInsets.only(top: 560,),
                  child: const Column(
                    children: [
                      Text("WeChat",
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,letterSpacing: 2,),
                      ),
                      Text("\nMade In India With Flutter",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,letterSpacing: 1,)
                      )
                    ],
                  ),
                )),
          ),
        )
      ],
    );
  }
}
