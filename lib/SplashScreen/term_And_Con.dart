import 'package:flutter/material.dart';
import 'package:wechat/SplashScreen/landing_page.dart';
import 'package:wechat/Themes/constants.dart';

class Term_And_Con extends StatelessWidget {
  Term_And_Con();



  void navigatorLandingScreen(BuildContext context){
    Navigator.pushNamed(context, Landing_Page.Landing_PageRoutName);
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(top: 15.0,left: 15),
              child: InkWell(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Landing_Page(),)),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                ),
              ),
            ),
            toolbarHeight: 90,
            expandedHeight: 110,
            pinned: true,
            backgroundColor: kPrimaryColor,
            title:const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Column(
                children: [
                Text("Terms Of Services And Privacy Policy",
                  style: TextStyle(fontSize: 17,
                  fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                ),
                Text("Last Updated: November 24,2023",
                  style: TextStyle(fontSize: 17,
                  fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                ),
                ],
              ),
            ) ,
          ),
          SliverToBoxAdapter(
            child:Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 7),
              child: RichText(
                text:const TextSpan(
                  children: [
                    TextSpan(
                        style: TextStyle(fontSize: 17,wordSpacing: 1),
                        text: 'In order to provide our Services (as defined below) through our apps, '
                            'services, features, software, or website, we need to obtain your agreement to our Terms of Service ("Terms").\n'
                            '\nWeChat LLC ("WeChat," "our," "we," or "us") provides the services described below to you ("Services").'
                    ),
                    TextSpan(
                        style: TextStyle(fontSize: 25,color: kPrimaryColor,fontWeight: FontWeight.w700),
                        text: "\n\nAbout Our Services"),
                    TextSpan(text: "\n • Privacy And Security Principles :",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
                    TextSpan(text: 'Since we started WeChat, '
                        '''we've built our Services with strong privacy and security principles in mind.\n'''),
                    TextSpan(text: "•	Connecting You With Other People :",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
                    TextSpan(text: ' We provide, and always strive to improve, ways for you to communicate with other WeChat users including through messages, voice and video calls, sending images and video, showing your status, and sharing your location with others when you choose. We may provide a convenient platform that enables you to send and receive money to or from other users across our platform. '
                        'WeChat works with partners, service providers, '
                        'and affiliated companies to help us provide ways for you to connect with their services.'),
                    TextSpan(text: "\n •	Ways To Improve Our Services :",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
                    TextSpan(text:'We analyze how you make use of WeChat, in order to improve our Services, including helping businesses who use WeChat measure the effectiveness '
                        'and distribution of their services and messages. WeChat uses the information '
                        'it has and also works with partners, service providers, and affiliated companies to do this.'),
                    TextSpan(text: "•	Communicating With Businesses :",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
                    TextSpan(text: 'We provide, and always strive to improve, ways for you and businesses and other organizations, '
                        'to communicate with each other using our Services, such as through order, transaction, and appointment information,'
                        ' delivery and shipping notifications, product and service updates, and marketing.'),
                    TextSpan(text: "\n •	Safety, Security, And Integrity :",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
                    TextSpan(text: 'We work to protect the safety, security, and integrity of our Services. This includes appropriately dealing with abusive people '
                        'and activity violating our Terms. We work to prohibit misuse of our Services including harmful conduct '
                        'towards others, violations of our Terms and policies, and address situations where we may be able to help support '
                        'or protect our community. If we learn of people or activity like this, we will take appropriate action, '
                        'including by removing such people or activity or contacting law enforcement. '
                        'Any such removal will be in accordance with the “Termination” section below.'),
                    TextSpan(text: "\n •	Enabling Access To Our Services. ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
                    TextSpan(text: 'To operate our global Services, we need to store and distribute content and information in data centers '
                        'and systems around the world, including outside your country of residence. '
                        'The use of this global infrastructure is necessary and essential to provide our Services. '
                        'This infrastructure may be owned or operated by our service providers including affiliated companies.'),
                    TextSpan(text: "\n\nNO ACCESS TO EMERGENCY SERVICES:",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
                    TextSpan(text: 'There are important differences between our Services and your mobile phone and a fixed-line telephone '
                        'and SMS services. Our Services do not provide access to emergency services or emergency services providers, '
                        'including the police, fire departments, or hospitals, or otherwise connect to public safety answering points. '
                        'You should ensure you can contact your relevant emergency services providers through a mobile phone, '
                        'a fixed-line telephone, or other service.'),
                    TextSpan(text: "\nAge:",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
                    TextSpan(text: "You must be at least 13 years old to register for and use our Services according to Indian Age System. "
                        "In addition to being of the minimum required age to use our Services under applicable law, "
                        "if you are not old enough to have authority to agree to our Terms in India "
                        "your parent or guardian must agree to our Terms on your behalf. "
                        "Please ask your parent or guardian to read these Terms with you."),
                    TextSpan(text: "\nDevices And Software:",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
                    TextSpan(text: 'You must provide certain devices, software, and data connections to use our Services, '
                        'which we otherwise do not supply. In order to use our Services, you consent to manually or automatically '
                        'download and install updates to our Services. You also consent to our sending you notifications '
                        'via our Services from time to time, as necessary to provide our Services to you.'),
                    TextSpan(text: "\nFees And Taxes:",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
                    TextSpan(text:'You are responsible for all carrier data plans, Internet fees, and other fees and '
                        'taxes associated with your use of our Services.' ),
                    TextSpan(text: "\n\nPrivacy Policy And User Data",style: TextStyle(color: kPrimaryColor,fontSize: 20,fontWeight: FontWeight.w700)),
                    TextSpan(text: "\nWeChat cares about your privacy. WeChat’s "),
                    TextSpan(text: ' Privacy Policy ',style: TextStyle(color: Colors.blue)),
                    TextSpan(text: 'describes our data (including message) practices, including the types of information we receive '
                        'and collect from you, how we use and share this information, and your rights in relation to the processing '
                        'of information about you.'),
                    TextSpan(text: "\n\nAcceptable Use Of Our Services",style: TextStyle(color: kPrimaryColor,fontSize: 20,fontWeight: FontWeight.w700)),
                    TextSpan(text: '\nOur Terms And Policies: ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700)),
                    TextSpan(text: 'You must use our Services according to our Terms and posted policies. '
                        'If you violate our Terms or policies, we may take action with respect to your account, '
                        'including disabling or suspending your account and, if we do, '
                        'you agree not to create another account without our permission'),
                    TextSpan(text: "\nLegal And Acceptable Use:",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700)),
                    TextSpan(text: 'You must access and use our Services only for legal, authorized, and acceptable purposes. '
                        'You will not use (or assist others in using) our Services in ways that: '
                        '\n(a) violate, misappropriate, or infringe the rights of WeChat, our users, or others, including privacy, publicity, '
                        'intellectual property, or other proprietary rights; '
                        '\n(b) are illegal, obscene, defamatory, threatening, intimidating, harassing, hateful, racially or ethnically offensive, '
                        'or instigate or encourage conduct that would be illegal or otherwise inappropriate, such as promoting violent crimes, '
                        'endangering or exploiting children or others, or coordinating harm; '
                        '\n(c) involve publishing falsehoods, misrepresentations, or misleading statements; '
                        '\n(d) impersonate someone; '
                        '\n(e) involve sending illegal or impermissible communications such as bulk messaging, auto-messaging, auto-dialing, and the like;'
                        '\n(f) or involve any non-personal use of our Services unless otherwise authorized by us.'),
                    TextSpan(text: "\n\nUpdates To Our Policy:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: kPrimaryColor)),
                    TextSpan(text: 'We may amend or update our Privacy Policy. We will provide you notice of amendments to this Privacy Policy, as appropriate, '
                        'and update the “Effective Date” at the top of this Privacy Policy. Please review our Privacy Policy from time to time.'),
                    TextSpan(text: "\n\nContact Us",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: kPrimaryColor)),
                    TextSpan(text: '\nIf you have questions or issues about our Privacy Policy, please contact us.'),
                    TextSpan(text: "\n\nWeChat LLC, \nBhopal Indore HighWay \nKothrikalan, Sehore \nMadhya Pradesh – 466114"),
                    TextSpan(text: "\nGmail-Id - aniketh.pratihar2020@vitbhopal.ac.in")




                  ]
                )
              ),
            )
          
          )
        ],
      )

    );
  }
}
