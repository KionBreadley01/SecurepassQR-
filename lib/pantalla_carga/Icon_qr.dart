
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';

class Iconqr extends StatefulWidget {
  const Iconqr({Key? key}) : super(key: key);

  @override
  State<Iconqr> createState() => _IconqrState();
}

class _IconqrState extends State<Iconqr> {
  @override
  void initState() {
  super.initState();
  Timer(
    const Duration(seconds: 2),
    () => Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginScreen(),
      ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logoqr.png',
              width: 400,
              height: 300,
            ),
            SizedBox(
              width: 150, // Ancho mediano
              height: 150, // Altura mediana
              child: Image.asset(
                'assets/images/ssssssssssssssssssssssssssssssss-removebg-preview (2).png',
                fit: BoxFit.scaleDown, // Ajusta la imagen al contenedor
              ),
            ),
          ],
        ),
      ),
    );
  }
}


