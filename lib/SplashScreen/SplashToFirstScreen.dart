import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wechat/Screens/LoginDetails/LoginScreen.dart';

class SplashScreenToFirst extends StatefulWidget {
  const SplashScreenToFirst({super.key});

  @override
  State<SplashScreenToFirst> createState() => _SplashScreenToFirstState();
}

class _SplashScreenToFirstState extends State<SplashScreenToFirst> with TickerProviderStateMixin {


  // To control the Animation
  late AnimationController _rippleController;
  late AnimationController _scalecontroller;

  // Declare variable
  late Animation<double> _rippleAnimation;
  late Animation<double> _scaleAnimation;

  // Check The arrow button pressed if yes then it will remove immediately
  bool hideIcon = false;


  // Animation InitState
  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
        vsync: this,
      duration: const Duration(
        seconds: 1
      )
    );

    _scalecontroller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1)
    )..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _scalecontroller.reverse();
        Navigator.pushAndRemoveUntil(context, PageTransition( type: PageTransitionType.fade,
        child: const LoginPage()),(route) => false,);
      }
    });

    _rippleAnimation =Tween<double>(begin: 80.0,end: 90.0).animate(_rippleController)..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _rippleController.reverse();
      }
      else if(status == AnimationStatus.dismissed){
        _rippleController.forward();
      }
    });

    _scaleAnimation = Tween<double>(begin: 1.0,end: 30.0).animate(_scalecontroller);

    _rippleController.forward();

  }

  @override
  void dispose() {
    _rippleController.dispose();
    _scalecontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2,),
              Image.asset("images/welcome_image.png"),
              const Spacer(flex: 1,),
              Text("Welcome",
              style:Theme.of(context).
              textTheme.
              headlineMedium?.
              copyWith(fontWeight: FontWeight.w900,
                fontSize: 35
              ),
              ),
              Text("Talk with anyone of Your\n native language",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                  color: Theme.of(context).
                  textTheme.
                  bodySmall?.color?.withOpacity(.7)),
              ),
              const Spacer(flex: 2,),
              Align(
                alignment: Alignment.bottomCenter,

                // Button Related Animation Work Here
                child: AnimatedBuilder(
                  animation: _rippleAnimation,
                  builder: (context, child) => SizedBox(
                    width: _rippleAnimation.value,
                    height: _rippleAnimation.value,
                    //On Tap press next Screen
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          hideIcon = true;
                          _scalecontroller.forward();
                        });
                      },
                      // Inkwell Press Rounded
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      child: AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) =>Transform.scale(
                          scale: _scaleAnimation.value,

                          // For Stacking deep red over light red
                          child: Stack(
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration:  BoxDecoration(
                                      color: Colors.red.withOpacity(.4),
                                      borderRadius: const BorderRadius.all(Radius.circular(100))
                                  ),
                                ),
                                Positioned(
                                  left: 7,
                                  top: 8,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration:  const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(Radius.circular(100))
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 17,
                                    left: 18,
                                    child: hideIcon == false ?const Icon(Icons.arrow_forward_rounded,size: 40,color: Colors.white,):
                                    Container())
                              ]

                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2,)
            ],
          ))
    );
  }
}
