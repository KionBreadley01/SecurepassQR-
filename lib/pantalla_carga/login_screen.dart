import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:securepassqr/pantalla_carga/student_information.dart';

// Servicio para interactuar con la base de datos MongoDB
class MongoDBService {
  final mongo.Db _db = mongo.Db(
      'mongodb+srv://juansanchezjuan125:Don_gato01@clusteruwu.znjsusx.mongodb.net/');

  // Método para autenticar al usuario
  Future<bool> authenticate(String username, String password) async {
    try {
      await _db.open(); // Abrir la conexión con la base de datos
      var collection =
          _db.collection('alumnos'); // Obtener la colección 'alumnos'
      var result = await collection.findOne(mongo.where
          .eq('Correo', username)
          .eq('Contraseña',
              password)); // Buscar el usuario por correo y contraseña
      return result != null; // Si se encontró el usuario, retorna true
    } catch (e) {
      Text(
          'Error autenticando: $e'); // Imprimir el error si ocurre uno durante la autenticación
      return false; // Retornar false si ocurre un error
    } finally {
      await _db.close(); // Cerrar la conexión con la base de datos
    }
  }
}

// Pantalla de inicio de sesión
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final MongoDBService _mongoDBService = MongoDBService();
  bool _isPasswordVisible = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 119, 208),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 500,
                  height: 250,
                  child: Image.asset(
                    'assets/images/logoqr.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(height: 50.0),
                // Campo de entrada para el nombre de usuario
                Container(
                  width: 359.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 87, 84, 84), // Color del borde
                      width: 1.0, // Ancho del borde
                    ),
                  ),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border:
                          InputBorder.none, // Eliminamos el borde del TextField
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                // Campo de entrada para la contraseña
                Container(
                  width: 359.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(
                      color: const Color.fromARGB(255, 87, 84, 84),
                      width: 1.0, // Ancho del borde
                    ),
                  ),
                  child: TextField(
                    obscureText: !_isPasswordVisible,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border:
                          InputBorder.none, // Eliminamos el borde del TextField
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                // Botón para iniciar sesión
                ElevatedButton(
                  onPressed: () async {
                    // String username = _usernameController.text;
                    // String password = _passwordController.text;
                    // bool isAuthenticated =
                    //     await _mongoDBService.authenticate(username, password);
                    // if (isAuthenticated) {
                    // Navegar a la pantalla de información del estudiante si la autenticación es exitosa
                    Future.delayed(const Duration(seconds: 4), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentInformation(),
                        ),
                      );
                    });

                    // } else {
                    //   // Limpiar los campos de usuario y contraseña
                    //   // Mostrar un mensaje de error si la autenticación falla
                    //   setState(() {
                    //     _errorMessage = 'Authentication failed';
                    //     // _usernameController.clear(); // Limpiar el campo de usuario
                    //     // _passwordController.clear(); // Limpiar el campo de contraseña
                    //     _isPasswordVisible = false;  // Restablecer la visibilidad de la contraseña
                    //   });
                    // }
                  },
                  child: const Text('Login'),

                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 183, 122, 173),
                    onPrimary: Colors.white,
                    minimumSize: const Size(359.0, 50.0),
                    elevation: 5.0,
                    shadowColor: Colors.grey,
                       
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                ),
                // Mostrar el mensaje de error si existe uno
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void Timer(Duration duration, Future push) {}
}

// Función principal para ejecutar la aplicación
void main() {
  runApp(const MaterialApp(
    title: 'Login App',
    home: LoginScreen(),
  ));
}
