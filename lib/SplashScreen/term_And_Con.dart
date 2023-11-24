import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat/Themes/constants.dart';

class Term_And_Con extends StatefulWidget {
  const Term_And_Con({super.key});

  @override
  State<Term_And_Con> createState() => _Term_And_ConState();
}

class _Term_And_ConState extends State<Term_And_Con> {

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
          child: Icon(
            Icons.article_outlined,
            size: size.height * .075,
            color: Colors.white,
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

              child: Column(
                children: [

                  Expanded(child: Container(

                  )),

                  Container(
                    height: 75,
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 0.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * .035),
                      child: Row(
                        children: [
                          Expanded(child: AcceptButton(name: "Decline", onTap: (){})),
                          SizedBox(width: size.width *.02,),
                          Expanded(child: AcceptButton(name: "Accept",isAccepted: true, onTap: (){})),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          )),

    );
  }
}

class AcceptButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final bool isAccepted;
  const AcceptButton({super.key, required this.name, required this.onTap, this.isAccepted = false});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: isAccepted ? Colors.green : Colors.blue
          ),
          backgroundColor: isAccepted ? Colors.red : Colors.white,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
        ),
          onPressed: ()=> onTap() ,
          child:Text(name,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w700,
                color: isAccepted ? Colors.blueAccent : kPrimaryColor
            ),
          ),
      ),
    );
  }
}

