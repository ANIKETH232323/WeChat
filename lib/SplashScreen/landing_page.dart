import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Screens/LoginDetails/LoginScreen1.dart';
import 'package:wechat/Themes/constants.dart';
import 'package:wechat/dialoge_box/policy_dialoge.dart';

class Landing_Page extends StatefulWidget {
  const Landing_Page({super.key});
  static const Landing_PageRoutName = '/landing_screen';

  @override
  State<Landing_Page> createState() => _Landing_PageState();
}

void navigatorLoginScreen(BuildContext context) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return const LoginPage1();
    },
  ), (route) => false);
}

class _Landing_PageState extends State<Landing_Page> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "Welcome to WeChat",
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'OnePlus',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h.height / 9,
            ),
            Image.asset(
              "images/bg_landing.png",
              height: 350,
              width: 350,
              color: kPrimaryColor,
            ),
            SizedBox(height: h.height / 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontFamily: 'OnePlus',
                            fontWeight: FontWeight.bold),
                        children: [
                          const TextSpan(
                              text: "Read our ",
                              style: TextStyle(fontSize: 16)),
                          TextSpan(
                              text: "Privacy Policy. ",
                              style: const TextStyle(
                                  color: Colors.blueAccent, fontSize: 16),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Policy_PopUp(
                                          mdFile: 'privacy_policy.md');
                                    },
                                  );
                                }),
                          const TextSpan(
                              text: "Tap ", style: TextStyle(fontSize: 16)),
                          const TextSpan(
                              text: '"Agree and continue"',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          const TextSpan(
                              text: "\n to accept the",
                              style: TextStyle(fontSize: 16)),
                          TextSpan(
                            text: " Terms of Service.",
                            style: const TextStyle(
                                color: Colors.blueAccent, fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigator.push(context, AppTransition().term_And_Cond);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Policy_PopUp(
                                        mdFile: 'termandcondition.md');
                                  },
                                );
                              },
                          ),
                        ])),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => navigatorLoginScreen(context),
              style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  minimumSize: const Size(350, 50),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              child: const Text("Agree and Continue",
                  style: TextStyle(
                      fontFamily: 'OnePlus',
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
            )
          ],
        ),
      )),
    );
  }
}
