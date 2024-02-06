import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Model/chatUserModel.dart';
import '../Themes/constants.dart';


class ProfileScreen extends StatefulWidget {
  final ChatUserModel chatUserModel;
  const ProfileScreen({super.key, required this.chatUserModel});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Top App bar Green
          Container(
            height: 300,
            decoration: const BoxDecoration(
                color: kPrimaryColor
            ),
          ),

          // Top App bar back button and edit button
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  // Back Button
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),

                  // Edit Profile Text
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),

                  // Edit Button Have to be removed
                  Padding(
                    padding: const EdgeInsets.only(top: 40, right: 20),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),


          const CardHolder(),
          Positioned(
            top: 135,
            left: 145,
            child: Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.green,
                  border: Border.all(
                      color: Colors.blueAccent.withOpacity(.2), width: 1)),
              child: const Icon(CupertinoIcons.person_alt_circle),
            ),
          ),
          const CardHolder1(),
          const CardHolder2()

        ],
      ),
    );
  }
}

class CardHolder extends StatelessWidget {
  const CardHolder({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 200, right: 20, left: 20),
      height: 170,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: titleColor.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 10),
          ]),
      child: const Card(),
    );
  }
}

class Card extends StatelessWidget {
  const Card({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[

        SizedBox(
          height: 70,
        ),
        Text(
          'Aniketh Pratihar',
          style: TextStyle(
            color: titleColor,
            fontSize: 20,
            fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Joined On 02.02.2024',
              style: TextStyle(color: textColor, fontSize: 15),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'at 8.45 PM',
              style: TextStyle(color: textColor, fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }
}



class CardHolder1 extends StatelessWidget {
  const CardHolder1({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 500, right: 20, left: 20),
      height: 80,
      width: 400,
      decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10)),),
      child: const Padding(
        padding: EdgeInsets.all(17.0),
        child: Card1(),
      ),
    );
  }
}

class Card1 extends StatelessWidget {
  const Card1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      Text(
        'Email - ',
        style: TextStyle( fontSize: 20,fontWeight: FontWeight.w700),
      ),

      Text(
        'xyz@gmail.com',
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
      ),
    ],);
  }
}



class CardHolder2 extends StatelessWidget {
  const CardHolder2({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 98.0),
      child: Container(
        margin: const EdgeInsets.only(top: 500, right: 20, left: 20),
        height: 80,
        width: 400,
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10)),),
        child: const Padding(
          padding: EdgeInsets.all(17.0),
          child: Card2(),
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      Text(
        'About - ',
        style: TextStyle( fontSize: 20,fontWeight: FontWeight.w700),
      ),

      Text(
        'Hello',
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
      ),
    ],);
  }
}