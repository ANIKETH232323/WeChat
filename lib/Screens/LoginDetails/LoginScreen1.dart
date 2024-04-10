import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:wechat/SplashScreen/AppBarBody/MessageToHomeScreen.dart';

import '../../Animation/loginPageAnimation.dart';
import '../../Api/Api.dart';
import '../../dialoge_box/snackBar.dart';

class LoginPage1 extends StatefulWidget {
  const LoginPage1({super.key});

  @override
  State<LoginPage1> createState() => _LoginPage1State();
}

class _LoginPage1State  extends State<LoginPage1>{



  _signInGoogleBtn(){

    // for showing progress bar
    SnackBar1.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      // for hiding progress bar
      Navigator.pop(context);
      if(user != null){
        log('\nuser:${user.user}');
        log('\nuser:${user.additionalUserInfo}');

        if(await Api.checkUser()){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomeScreen() ));
        }
        else{
          await Api.createUser().then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomeScreen() ));
        });
      }



      }
    },);
  }


  // Google Sign-in code
  Future<UserCredential?> _signInWithGoogle() async {
    try{
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    catch(e){
      
      log('The error is $e');
      SnackBar1.showFloatingSnackBar(context, "Successfull");
      return null;
    }
  }














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Stack(
          children: [
            Container(
            padding: const EdgeInsets.only(top: 150),
            height: double.maxFinite,
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
                      _signInGoogleBtn();
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
                                  color: Colors.black,fontFamily: 'OnePlus',fontWeight:FontWeight.bold,fontSize: 18),)
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
