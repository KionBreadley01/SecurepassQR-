import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: SizedBox(
          width: 400, // Ancho de la tarjeta
          height: 400, // Largo de la tarjeta
          child: Card(
            elevation: 5, // Agrega sombra a la tarjeta
            color: const Color.fromARGB(255, 252, 252, 252), // Cambia el color de la tarjeta
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // Cambia el radio de las esquinas para darle forma
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200, // Ancho pequeño
                  height: 100, // Altura pequeña
                  child: Image.asset(
                    'assets/images/logoqr.png',
                    fit: BoxFit.scaleDown, // Ajusta la imagen al contenedor
                  ),
                ),
                const SizedBox(height: 30), // Espaciado ajustable
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Agrega lógica para verificar la autenticación
                          // Puedes usar Navigator para navegar a la siguiente pantalla después del inicio de sesión exitoso.
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 19),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
