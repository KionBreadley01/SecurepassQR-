import 'dart:async';

import 'package:flutter/material.dart';

class Iconqr extends StatefulWidget {
  const Iconqr({super.key});

  @override
  State<Iconqr> createState() => _IconSplashState();
}

class _IconSplashState extends State<Iconqr> {
  @override
  void initState() {
    super.initState();
    Timer(
       const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const Iconqr())));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Image.asset(
            'assets/images/logoqr.png',
            width: 300,
            height: 200,
          ), 
          Image.asset(
            'assets/images/ssssssssssssssssssssssssssssssss-removebg-preview (1).png',
             width: 3000,
            height: 400,
          ),
            const Text(
              "",
              style: TextStyle(fontSize: 20),
            ),
          const   Text(
              "",
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
     ),
);
}
}