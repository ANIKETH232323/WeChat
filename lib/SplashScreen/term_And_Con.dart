import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat/SplashScreen/landing_page.dart';
import 'package:wechat/Themes/constants.dart';

class Term_And_Con extends StatelessWidget {
  Term_And_Con();



  void navigatorLandingScreen(BuildContext context){
    Navigator.pushNamed(context, Landing_Page.Landing_PageRoutName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: kPrimaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(18.0),
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Landing_Page(),));
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: size.height * .040,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Center(
                    child: Text("Terms Of Services And Privacy Policy",
                      style: TextStyle(fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .005),
                  const Center(
                    child: Text("Last Updated: November 24,2023",
                      style: TextStyle(fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      body: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Container(

            ),
          )),

    );
  }
}
