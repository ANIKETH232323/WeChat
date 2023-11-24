import 'package:flutter/material.dart';
import 'package:wechat/Screens/LoginDetails/LoginScreen.dart';

Route<dynamic> generateRoutes(RouteSettings settings){
  switch(settings.name){
    case LoginPage.LoginRoutName:
      return MaterialPageRoute(
          builder: (context) => const LoginPage());
    default:
      return MaterialPageRoute(builder: (context)=>const Scaffold(
        body: Text("Check Your Internet Connection"),
      ));
  }
}