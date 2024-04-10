import 'package:firebase_auth/firebase_auth.dart'; // Importa el paquete de autenticación de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:securepassqr/firebase_options.dart';
import 'package:securepassqr/pantalla_carga/icon_qr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Agregar el código para escuchar los cambios en el estado de autenticación del usuario
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('Usuario no autenticado');
    } else {
      print('Usuario autenticado: ${user.uid}');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SecurePassQR',
      debugShowCheckedModeBanner: false,
      home: Iconqr(),
    );
  }
}
