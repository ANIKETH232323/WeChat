import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


// delete later

class AppTransition{
  PageTransition term_And_Cond = PageTransition(
      child: Container(),
      type: PageTransitionType.bottomToTop,
      alignment: Alignment.center,
    curve: Curves.easeIn,
    duration: const Duration(milliseconds: 500),
  );
}