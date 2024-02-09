import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wechat/Api/Api.dart';
import 'package:wechat/Model/chatUserModel.dart';
import 'package:wechat/Screens/LoginDetails/LoginScreen1.dart';
import 'package:wechat/SplashScreen/AppBarBody/MessageToHomeScreen.dart';
import 'package:wechat/dialoge_box/snackBar.dart';
import '../Themes/constants.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUserModel chatUserModel;
  const ProfileScreen({super.key, required this.chatUserModel});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Stack(
            children: <Widget>[
              // Top App bar Green
              Container(
                height: 300,
                decoration: const BoxDecoration(color: kPrimaryColor),
              ),

              // The Whole Card Box
              Container(
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // No 1 - Some Space
                      Column(
                        children: <Widget>[
                          // Some Space
                          const SizedBox(
                            height: 65,
                          ),

                          // Log in User Name and Text Form Field
                          SizedBox(
                            width: 250,
                            // Text Form FIeld
                            child: TextFormField(
                              initialValue: widget.chatUserModel.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                              onSaved: (newValue) =>
                                  Api.me.name = newValue ?? '',
                              validator: (value) =>
                                  value != null && value.isNotEmpty
                                      ? null
                                      : 'Required Field',
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),

                          // Space
                          const SizedBox(
                            height: 10,
                          ),

                          // Joined Date and Time
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Joined On 02.02.2024',
                                style:
                                    TextStyle(color: textColor, fontSize: 15),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'at 8.45 PM',
                                style:
                                    TextStyle(color: textColor, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Email Box
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 15.0, right: 15.0),
                        child: Column(
                          children: [
                            // Email Box
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 5),
                                        color: Colors.grey.withOpacity(.2),
                                        spreadRadius: 2,
                                        blurRadius: 10)
                                  ]),
                              child: ListTile(
                                title: const Text("Email"),
                                subtitle: Text(widget.chatUserModel.email),
                                leading: const Icon(Icons.email),
                              ),
                            ),

                            // Space
                            const SizedBox(
                              height: 15,
                            ),

                            // About Box
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 5),
                                        color: Colors.grey.withOpacity(.2),
                                        spreadRadius: 2,
                                        blurRadius: 10)
                                  ]),
                              child: ListTile(
                                title: const Text("About"),
                                subtitle: SizedBox(
                                  height: 25,
                                  child: TextFormField(
                                    initialValue: widget.chatUserModel.about,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                    enableInteractiveSelection: false,
                                    onSaved: (newValue) =>
                                        Api.me.about = newValue ?? '',
                                    validator: (value) =>
                                        value != null && value.isNotEmpty
                                            ? null
                                            : 'Required Field',
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                leading: const Icon(
                                    CupertinoIcons.refresh_circled_solid),
                                tileColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // NO 3
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Center(
                          child: SizedBox(
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                    Api.UpdateProfileName().then(
                                      (value) {
                                        SnackBar1.showFloatingSnackBar(context,
                                            "Profile Updated Successfully");
                                      },
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.all(15),
                                ),
                                child: const Text('Update Profile')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // END HERE

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
                      padding: const EdgeInsets.only(top: 40, left: 5),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => const HomeScreen(),));
                        },
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
                        onPressed: () async {
                          SnackBar1.showProgressBar(context);
                          await Api.auth.signOut().then(
                            (value) async {
                              await GoogleSignIn().signOut().then(
                                (value) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage1(),
                                      ));
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Edit Profile Text and The Profile Picture and The edit button
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Edit Profile Text
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),

                    Stack(
                      children: [
                        SizedBox(
                          height: 145,
                          width: 145,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                              imageUrl: widget.chatUserModel.image,
                              errorWidget: (context, url, error) =>
                                  const CircleAvatar(
                                      child: Icon(CupertinoIcons.person)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 95,
                          left: 95,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(25)),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
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
            ],
          ),
        ),
      ),
    );
  }
}
