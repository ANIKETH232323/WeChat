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

          CardHolder(about: widget.chatUserModel.about,email: widget.chatUserModel.email),
          // Top App bar back button and Edit Profile Text
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                // Back Button
                Padding(
                  padding: const EdgeInsets.only(top: 40,left: 20),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),




                // Log Out Button
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 20),
                  child: IconButton(
                    icon: const Icon(
                      Icons.power_settings_new_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),



              ],
            ),
          ),

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Edit Profile Text
                const Padding(
                  padding: EdgeInsets.only(top: 50,),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                const SizedBox(height: 35,),

                Stack(
                  children: [
                    Container(
                      height: 145,
                      width: 145,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.yellow,
                          border: Border.all(
                              color: Colors.blueAccent.withOpacity(.2), width: 1)),
                      child: const Icon(CupertinoIcons.person_alt_circle),
                    ),

                    Positioned(
                      top: 95,
                      left: 95,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                )



              ],
            ),
          ),
          // Image Edit Button



          //person image will be displayed here


        ],
      ),
    );
  }
}

class CardHolder extends StatelessWidget {
  final String about;
  final String email;
  const CardHolder({super.key, required this.about, required this.email});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 200, right: 15, left: 15),
      height: 450,
      width: 450,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: titleColor.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 10),
          ]),
      child: Column(
        children: [
          const Card(),
          CardHolder1(email: email,about: about),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: SizedBox(
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text('Update Profile')
                ),),
            ),
          ),
          // Card1(email: email),
          // Card2(about: about)
        ],
      ),
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


// For Email Card Field and about card field
class CardHolder1 extends StatelessWidget {
  final String email;
  final String about;
  const CardHolder1({super.key, required this.email, required this.about});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 57.0,left: 15.0,right: 15.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 5),
                      color: Colors.grey.withOpacity(.2),
                      spreadRadius: 2,
                      blurRadius: 10
                  )
                ]
            ),
            child: ListTile(
              title: const Text("Email"),
              subtitle: Text(email),
              leading: const Icon(Icons.email),
              trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
              tileColor: Colors.white,
            ),
          ),
          const SizedBox(height: 34,),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 5),
                      color: Colors.grey.withOpacity(.2),
                      spreadRadius: 2,
                      blurRadius: 10
                  )
                ]
            ),
            child: ListTile(
              title: const Text("About"),
              subtitle: Text(about),
              leading: const Icon(Icons.email),
              trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
              tileColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// class Card1 extends StatelessWidget {
//   final String  email;
//   const Card1({super.key, required this.email});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(children: [
//
//       const Text(
//         'Email - ',
//         style: TextStyle( fontSize: 15,fontWeight: FontWeight.w700),
//       ),
//
//       Text(email,
//         style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700),
//       ),
//     ],);
//   }
// }
//
//
//
// // For about Card Field
// class CardHolder2 extends StatelessWidget {
//   final String about;
//   const CardHolder2({super.key,required this.about});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 12, right: 20, left: 20),
//       height: 80,
//       width: 400,
//       decoration: const BoxDecoration(
//         color: Colors.black12,
//         borderRadius: BorderRadius.all(Radius.circular(10)),),
//       child: Padding(
//         padding: const EdgeInsets.all(17.0),
//         child: Card2(about: about),
//       ),
//     );
//   }
// }
//
// class Card2 extends StatelessWidget {
//   final String about;
//   const Card2({super.key,required this.about});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(children: [
//       const Text(
//         'About - ',
//         style: TextStyle( fontSize: 20,fontWeight: FontWeight.w700),
//       ),
//
//       Text(about,
//         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
//       ),
//     ],);
//   }
// }