import 'package:flutter/material.dart';

class SnackBar1{

  static void showFloatingSnackBar(BuildContext context, String msg) {

    final snackBar = SnackBar(
        content: Row(
          children: [
            const Icon(Icons.person_2_rounded),
            const SizedBox(width: 15,),
            Center(child: Text(msg,textAlign: TextAlign.center,)),
          ],
        ),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.fixed,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showProgressBar(BuildContext context){
      showDialog(
          context: context,
          builder: (_)=> const Center(child: CircularProgressIndicator()));
  }
}