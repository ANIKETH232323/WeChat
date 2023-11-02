import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat/SplashScreen/AppBarBody/Body.dart';
import 'package:wechat/Themes/constants.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30.0,right: 20),
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
    );
  }

  AppBar buildAppBar() {
    return AppBar(

      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor),
      backgroundColor: kPrimaryColor,
      title: const Column(
        children: [
          Text("Wechat",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700)),

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
