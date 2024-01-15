import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:wechat/Themes/constants.dart';

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
