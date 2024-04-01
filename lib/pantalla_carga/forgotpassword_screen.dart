import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes enviar el enlace de recuperación de contraseña al correo electrónico proporcionado
                _resetPassword(_emailController.text, context);
              },
              child: const Text('Enviar enlace de recuperación'),
            ),
          ],
        ),
      ),
    );
  }

  void _resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Se ha enviado un enlace de recuperación a tu correo electrónico.'),
          backgroundColor: Colors.green,
        ),
      );
      // Después de enviar el correo electrónico, puedes navegar a la pantalla de inicio de sesión
      Navigator.pop(context);
    } catch (e) {
      print("Error al enviar el enlace de recuperación: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al enviar el enlace de recuperación: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
