import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Animation/transition.dart';
import 'package:wechat/Screens/LoginDetails/LoginScreen.dart';
import 'package:wechat/Themes/constants.dart';


class Landing_Page extends StatefulWidget {
  const Landing_Page({super.key});
  static const Landing_PageRoutName = '/landing_screen';

  @override
  State<Landing_Page> createState() => _Landing_PageState();
}
void navigatorLoginScreen(BuildContext context){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
    return LoginPage();
  },), (route) => false);
  }

class _Landing_PageState extends State<Landing_Page> {

  @override

  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size;
    return  Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Welcome to WeChat",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: h.height/9,),
                Image.asset("images/bg_landing.png",height: 350,width: 350,color: kPrimaryColor,),
                SizedBox(height: h.height / 17),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: const TextStyle(color: kPrimaryColor,fontSize: 15),
                            children: [
                              const TextSpan(text: "Read our ",style: TextStyle(fontSize: 16)),
                              TextSpan(text: "Privacy Policy. ",style: const TextStyle(color: Colors.blueAccent,fontSize: 16),

                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context, AppTransition().term_And_Cond);
                                    }),
                              const TextSpan(text: "Tap ",style: TextStyle(fontSize: 16)),
                              const TextSpan(text: '"Agree and continue"',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
                              const TextSpan(text: "\n to accept the",style: TextStyle(fontSize: 16)),
                              TextSpan(text: " Terms of Service.",style: const TextStyle(color: Colors.blueAccent,fontSize: 16),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context, AppTransition().term_And_Cond);
                                    },
                              ),
                            ]
                          )
                      ),
                    ],
                  ),),





                const SizedBox(height: 20,),
                ElevatedButton(onPressed: ()=> navigatorLoginScreen(context),
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor,
                      minimumSize: const Size(350, 50),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                  ),
                  child:const Text("Agree and Continue",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
                )
              ],
            ),
          )),
    );
  }
}
