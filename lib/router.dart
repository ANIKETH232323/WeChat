import 'package:flutter/material.dart';
import 'package:wechat/Screens/LoginDetails/LoginScreen.dart';
import 'package:wechat/SplashScreen/landing_page.dart';
import 'package:wechat/SplashScreen/term_And_Con.dart';

Route<dynamic> generateRoutes(RouteSettings settings){
  switch(settings.name){
    case LoginPage.LoginRoutName:
      return MaterialPageRoute(
          builder: (context) => const LoginPage());

      case Landing_Page.Landing_PageRoutName:
      return MaterialPageRoute(
          builder: (context) =>  Landing_Page());
    default:
      return MaterialPageRoute(builder: (context)=>const Scaffold(
        body: Text("Check Your Internet Connection"),
      ));
  }
}