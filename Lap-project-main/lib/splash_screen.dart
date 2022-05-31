import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer timer = Timer(Duration(seconds: 0), () => {});
  @override
  void initState() {
    timer = new Timer(
        Duration(seconds: 5),
        () => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomePage())));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      PageView(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 60),
              width: 200,
              height: 200,
              child: Image.asset(
                'img/img1.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
      Align(
        alignment: const Alignment(0, 0.7),
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          width: MediaQuery.of(context).size.width - 100,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              timer.cancel();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomePage()));
            },
            child: const Text('Get Started'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 19, 33, 224)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                )),
          ),
        ),
      )
    ]));
  }
}




















// const Color.fromARGB(255, 255, 255, 255)
// const Color.fromARGB(255, 247, 190, 2)
// const Color.fromARGB(255, 242, 138, 129)
// const Color.fromARGB(255, 251, 244, 118)
// const Color.fromARGB(255, 205, 255, 144)
// const Color.fromARGB(255, 215, 174, 252)
// const Color.fromARGB(255, 175, 202, 250)
// const Color.fromARGB(255, 230, 201, 169)
