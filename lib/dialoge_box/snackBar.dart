import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SnackBar1 {

  static void showSnackBar(BuildContext context, String msg) {
    final Snackbar01 = SnackBar(
      elevation: 0,
      padding: EdgeInsets.all(45),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: SizedBox(
        height: 85,
        child: AwesomeSnackbarContent(
            title: "Congratulations",
            message: "Sign-In Complete",
            contentType: ContentType.success),
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(Snackbar01);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)) as SnackBar);
  }

    static void showProgressBar(BuildContext context){
      showDialog(
          context: context,
          builder: (_)=> const Center(child: CircularProgressIndicator()));
    }
}