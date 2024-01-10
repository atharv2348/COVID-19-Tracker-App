import 'dart:async';

import 'package:covid_19_tracker_app/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldStates()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AnimatedBuilder(
            animation: _controller,
            child: Container(
              height: 200,
              width: 200,
              child: const Center(
                  child: Image(
                image: AssetImage("assets/images/virus.png"),
              )),
            ),
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: child,
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          const Text(
            "C O V I D - 1 9 \n Tracker App",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
