import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wechat/Themes/constants.dart';
import 'package:wechat/ignore_files.dart';

class Policy_PopUp extends StatelessWidget {
  const Policy_PopUp({
    super.key,
    this.radius = 9,
    required this.mdFile
  });

  final  double radius;

  final String mdFile;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child:Container(
        height: 600,
        child: Column(
          children: [
            Expanded(child: FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 150)).then((value){
                return rootBundle.loadString('termandcond/$mdFile');
              }),
              builder: (context, snapshot) {

              if(snapshot.hasData){
                return Markdown(
                    data: snapshot.data.toString(),
                  shrinkWrap: true,
                  selectable: true,
                  onTapLink: (text, href, title) {
                      if(text == "Google Play Services"){
                        final Uri _i = Uri.parse(href!);
                        launchUrl(_i);
                      }

                      else if(text == "Google Analytics for Firebase"){
                        final Uri _a = Uri.parse(href!);
                        launchUrl(_a);
                      }

                      else if(text == "Firebase Crashlytics"){
                        final Uri _b = Uri.parse(href!);
                        launchUrl(_b);
                      }

                      else{
                        String af = mail;
                        final String emailSubject = "[some subject here]";
                        final Uri parsedMailto = Uri.parse("mailto:<$af>?subject=$emailSubject");
                        launchUrl(parsedMailto);
                      }
                  },

                );
              }

              else{
                return const Center(child: CircularProgressIndicator());
              }
            },)),
            Container(

              width: double.infinity,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(radius),
                  bottomLeft: Radius.circular(radius)
                )
              ),
              child: TextButton(
                  onPressed: () =>Navigator.of(context).pop(),
                    child: const Text("CLOSE",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
