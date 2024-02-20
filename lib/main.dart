import 'package:flutter/material.dart';
import 'package:securepassqr/pantalla_carga/Icon_qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      title: 'Android Alians',
      debugShowCheckedModeBanner: false,
      home: Iconqr(),
    );
  }
}
class  TextView extends StatefulWidget {
  const TextView({super.key});

  @override
  TextViewState createState() => TextViewState();
} 
class TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Widget'),
      ),
      body: const Center(
        child: Text('Hello World!'),
     ),
);
}
}