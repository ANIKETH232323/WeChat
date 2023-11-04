import 'package:flutter/material.dart';
import 'package:wechat/Screens/LoginScreen.dart';
import 'package:wechat/Screens/Message/PersonalMessageScreen.dart';
import 'package:wechat/Screens/SplashScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // home: const PersonalMessageScreen()
      // home: const SplashScreen(),
      home: const LoginPage(),
    );
  }
}

