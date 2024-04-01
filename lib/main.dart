import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:securepassqr/firebase_options.dart';
import 'package:securepassqr/pantalla_carga/icon_qr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
