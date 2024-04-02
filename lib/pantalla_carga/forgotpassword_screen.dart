import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 224, 119, 208),
        title: const Text('Recuperar Contraseña'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 224, 119, 208),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 600,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ingresa tu correo electrónico registrado para recuperar tu contraseña.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20.0),
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
                            _resetPassword(_emailController.text, context);
                          },
                          child: const Text('Enviar enlace de recuperación'),
                        ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text('Volver al inicio de sesión'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _resetPassword(String email, BuildContext context) async {
    try {
      // Lógica para enviar el enlace de recuperación de contraseña
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
