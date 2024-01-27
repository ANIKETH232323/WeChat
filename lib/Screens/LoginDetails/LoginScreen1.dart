import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Animation/loginPageAnimation.dart';

class LoginPage1 extends StatelessWidget {
  const LoginPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Stack(
          children: [
            Container(
            padding: const EdgeInsets.only(top: 150),
            height: double.maxFinite,
            color: Colors.white,
              child: Lottie.asset("animation/hello.json",alignment: Alignment.topCenter),
        ),
            Padding(
              padding: const EdgeInsets.only(bottom: 208.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: LoginAnime(
                  delay: 1,
                  child: InkWell(
                    onTap: () {
                      // _HandleGoogleBtnClick();
                      final Snackbar = SnackBar(
                        elevation: 0,
                        padding: EdgeInsets.all(45),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: SizedBox(
                          height: 85,
                          child: AwesomeSnackbarContent(
                              title: "Congratulations",
                              message: "Sign-In Complete",
                              contentType: ContentType.success),
                        ),
                      );
                          ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(Snackbar);
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Container(
                      width: 300,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 35,
                                width: 35,
                                child: Image(image: AssetImage("images/google.png"))),
                            SizedBox(width: 25),
                            Text("Login With Google",
                              style: TextStyle(
                                  color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)
                          ]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
