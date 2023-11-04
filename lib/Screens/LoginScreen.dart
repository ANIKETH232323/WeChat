import 'package:flutter/material.dart';

import '../Animation/loginPageAnimation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return  Scaffold(

      body: Column(
        children: [
          SizedBox(
            height: height * .55,
            child: Stack(
              children: [
                Positioned(
                  top: -40,
                    width: width ,
                    height: 400,
                      child: LoginAnime(delay: .9,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(image:AssetImage("images/background.png"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                    )
                    ),
                Positioned(
                  width: width +20,
                    height: 400,
                    child: LoginAnime(
                      delay: .9,child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(image:AssetImage("images/background-2.png"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(

              children: [
                const LoginAnime(delay:1,child: Text("Login",
                  style: TextStyle(
                      fontSize: 29,fontWeight: FontWeight.bold),)),
                const SizedBox(height: 160,),
                LoginAnime(
                  delay: 1.1,
                  child: InkWell(
                    onTap: () {

                    },
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Container(
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
                            child: Image(image: AssetImage("images/google.png"))),
                        Text("Login With Google",
                          style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w700,fontSize: 17),)
                      ]),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
