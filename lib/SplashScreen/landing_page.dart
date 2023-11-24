import 'package:flutter/material.dart';
import 'package:wechat/Screens/LoginDetails/LoginScreen.dart';
import 'package:wechat/Themes/constants.dart';

class Landing_Page extends StatelessWidget {
  const Landing_Page({super.key});


  void navigatorLoginScreen(BuildContext context){
    Navigator.pushNamed(context, LoginPage.LoginRoutName);
  }

  @override
  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size;

    bool? ischecked = false;

    return  Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "Welcome to WeChat",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h.height/9,),
            Image.asset("images/bg_landing.png",height: 350,width: 350,color: kPrimaryColor,),
            SizedBox(height: h.height / 17),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Read our Privacy Policy. Tap ""Agree and continue"" \nto accept  the Terms of Service.",
                        style: TextStyle(color: Colors.white,fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      Checkbox(value: ischecked, onChanged: (bool? newvalue){

                        ischecked = newvalue;


                      }),
                    ],
                  ),),





            const SizedBox(height: 20,),
            ElevatedButton(onPressed: ()=> navigatorLoginScreen(context),
                child:const Text("Agree and Continue"),
              style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor,
                minimumSize: const Size(350, 50)
              ),
            )
          ],
        ),
      )),
    );
  }
}
