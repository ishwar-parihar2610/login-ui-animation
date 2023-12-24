import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:login_animation/login_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _scaleController;
  AnimationController? _scale2Controller;
  AnimationController? _widthController;
  AnimationController? _positionController;

  Animation<double>? _scaleAnimation;
  Animation<double>? _scale2Animation;
  Animation<double>? _widthAnimation;
  Animation<double>? _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController!.view)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController?.forward();
            }
          });

    _widthController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController!.view)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController?.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController!.view)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller!.forward();
            }
          });

    _scale2Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 50.0).animate(_scale2Controller!.view)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                      curve: Curves.bounceIn,
                      duration: const Duration(seconds: 1),
                      child: const LoginScreen(),
                      type: PageTransitionType.fade));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(3, 9, 23, 1),
        body: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  top: -50,
                  left: 0,
                  child: FadeInDown(
                    delay: const Duration(milliseconds: 100),
                    child: Container(
                      width: width,
                      height: 400,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/one.png"))),
                    ),
                  )),
              Positioned(
                  top: -150,
                  left: 0,
                  right: 0,
                  child: FadeInDown(
                    delay: const Duration(milliseconds: 120),
                    child: Container(
                      width: width,
                      height: 400,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/one.png"))),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInDown(
                      delay: const Duration(milliseconds: 150),
                      child: const Text(
                        "Welcome",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 170),
                      child: Text(
                        "We promis that you'll have the most \n good time with us",
                        style: TextStyle(
                            color: Colors.white.withOpacity(.7), height: 1.4),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(seconds: 1),
                      child: AnimatedBuilder(
                        animation: _scaleController!,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation?.value,
                            child: Center(
                              child: AnimatedBuilder(
                                  animation: _widthController!,
                                  builder: (context, child) {
                                    return Container(
                                      width: _widthAnimation?.value,
                                      height: 80,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.blue.withOpacity(.4)),
                                      child: InkWell(
                                        onTap: () {
                                          _scaleController?.forward();
                                        },
                                        child: Stack(
                                          children: [
                                            AnimatedBuilder(
                                                animation: _positionAnimation!,
                                                builder: (context, child) {
                                                  return Positioned(
                                                    left: _positionAnimation!
                                                        .value,
                                                    child: AnimatedBuilder(
                                                        animation:
                                                            _scale2Controller!,
                                                        builder:
                                                            (context, child) {
                                                          return Transform
                                                              .scale(
                                                            scale:
                                                                _scale2Animation
                                                                    ?.value,
                                                            child: Container(
                                                              height: 60,
                                                              width: 60,
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .blue,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: !hideIcon
                                                                  ? const Icon(
                                                                      Icons
                                                                          .arrow_forward,
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                                  : const SizedBox(),
                                                            ),
                                                          );
                                                        }),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
