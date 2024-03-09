import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:securepassqr/pantalla_carga/StudentInformation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          double cardWidth = sizingInformation.deviceScreenType == DeviceScreenType.mobile
              ? MediaQuery.of(context).size.width * 0.9
              : MediaQuery.of(context).size.width * 0.3;

          double cardHeight = sizingInformation.deviceScreenType == DeviceScreenType.mobile
              ? MediaQuery.of(context).size.height * 0.7
              : MediaQuery.of(context).size.height * 0.6;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 40.0,
            ),
            child: Center(
              child: SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: Card(
                  elevation: 5.0,
                  color: const Color.fromARGB(249, 233, 177, 227),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 100,
                          child: Image.asset(
                            'assets/images/logoqr.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Username',
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextField(
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: () {
                                // Implement your login logic here
                                // Currently navigates to StudentInformation screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const StudentInformation(),
                                  ),
                                );
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
