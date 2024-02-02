import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat/Api/Api.dart';
import 'package:wechat/SplashScreen/AppBarBody/Body.dart';
import 'package:wechat/SplashScreen/AppBarBody/MessageHomeScreenListDesign.dart';
import 'package:wechat/Themes/constants.dart';

// ***************************************Main Chats List will be done here******************************************

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0,right: 10),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(onPressed: (){},
                  backgroundColor: kPrimaryColor,
                  child:const Icon(Icons.person_add_alt_1_sharp) ,
                )),
          ],
        ),
      ),

      body: StreamBuilder(
        stream: Api.firestore.collection('user').snapshots(), //the user name should be same as firestore  database collection check that again
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final data = snapshot.data?.docs;
            for(var i  in data!){
              log('Data:${i.data()}');
            }

          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            physics: const BouncingScrollPhysics(),
            itemCount: 35,
            itemBuilder: (context, index) {
              return const HomeListDesign();
            },
          );
        },
      )
    );
  }

  AppBar buildAppBar() {
    return AppBar(

      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor),
      backgroundColor: kPrimaryColor,
      title: const Column(
        children: [
          Text("WeChat",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700)),

        ],
      ),
      toolbarHeight: 100,
      bottom: const PreferredSize(
          preferredSize: Size.fromHeight(15.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14,bottom: 8),
                child: BodyAppBar(),
              )

            ],
          )),
      actions: [
        IconButton(
            onPressed: (){}, icon: const Icon(Icons.search)),
        IconButton(
            onPressed: (){}, icon: const Icon(Icons.account_circle))
      ],
    );
  }
}
