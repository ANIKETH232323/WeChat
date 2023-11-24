import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wechat/SplashScreen/term_And_Con.dart';

class AppTransition{
  PageTransition term_And_Cond = PageTransition(
      child: Term_And_Con(),
      type: PageTransitionType.rotate,
      alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: Duration(milliseconds: 800),
  );
}