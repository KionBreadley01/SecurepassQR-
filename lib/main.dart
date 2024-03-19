import 'package:flutter/material.dart';
import 'package:securepassqr/pantalla_carga/icon_qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SecurePassQR',
      debugShowCheckedModeBanner: false,
      home: Iconqr(),
    );
  }
}
