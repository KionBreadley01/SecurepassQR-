import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:securepassqr/pantalla_carga/forgotpassword_screen.dart';
import 'package:securepassqr/pantalla_carga/signup_screen.dart';
import 'package:securepassqr/pantalla_carga/student_information.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email = "";
  String _password = "";
  bool _isObscure = true;

 void _handleLogin() async {
  try {
    UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
      email: _email,
      password: _password,
    );
    print("Usuario logeado: ${userCredential.user!.email}");
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StudentInformation(),
      ),
    );
  } catch (e) {
    print("Error durante el inicio de sesión: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error durante el inicio de sesión: $e"),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Evita que el contenido se desplace hacia arriba cuando aparece el teclado
      body: SingleChildScrollView( // Envuelve el contenido del Scaffold en SingleChildScrollView
        child: Container(
          color: const Color.fromARGB(255, 224, 119, 208),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 200,
                          child: Image.asset(
                            'assets/images/logoqr.png',
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: 'Ingresa tu correo electrónico',
                                  labelText: 'Correo electrónico',
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa tu correo electrónico';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _email = value;
                                  });
                                },
                                  autocorrect: false,
                                  autofillHints: const [AutofillHints.email],
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                  hintText: 'Ingresa tu contraseña',
                                  labelText: 'Contraseña',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: _togglePasswordVisibility,
                                    icon: Icon(
                                      _isObscure ? Icons.visibility : Icons.visibility_off,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa tu contraseña';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                                autocorrect: false,
                                autofillHints: const [AutofillHints.password],
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _handleLogin();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                ),
                                child: const Text(
                                  'Iniciar sesión',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                                  );
                                },
                                child: const Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextButton(
                                onPressed: () {
                                  // Navegar a la pantalla de registro
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                                  );
                                },
                                child: const Text(
                                  'Registrarse',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
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
}
