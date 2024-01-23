import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Animation/loginPageAnimation.dart';

class LoginPage1 extends StatelessWidget {
  const LoginPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
          padding: EdgeInsets.only(top: 20),
          height: double.maxFinite,
          color: Colors.white,
            child: Lottie.asset("animation/hello.json",alignment: Alignment.topCenter),
      ),
          Padding(
            padding: const EdgeInsets.only(bottom: 88.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LoginAnime(
                delay: 1,
                child: InkWell(
                  onTap: () {
                    // _HandleGoogleBtnClick();
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Container(
                    width: 350,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, 1),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                          )
                        ]
                    ),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              height: 35,
                              width: 35,
                              child: Image(image: AssetImage("images/google.png"),)),
                          Text("Login With Google",
                            style: TextStyle(
                                color: Colors.black,fontWeight: FontWeight.w700,fontSize: 17),)
                        ]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );

  }
}
