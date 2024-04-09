import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:securepassqr/pantalla_carga/about_screen.dart';
import 'package:securepassqr/pantalla_carga/accesshistory_screen.dart';
import 'package:securepassqr/pantalla_carga/helpcanter_screen.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';
import 'package:securepassqr/pantalla_carga/menuadmin_screen.dart';
import 'package:securepassqr/pantalla_carga/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa la biblioteca url_launcher

class StudentInformation extends StatelessWidget {
  const StudentInformation({Key? key}) : super(key: key);

// Función para abrir el correo electrónico en la aplicación de Gmail
  void _launchEmail() async {
    const emailAddress = 'securepassqr@gmail.com';
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch ${_emailLaunchUri.toString()}';
    }
  }
  

  @override
  Widget build(BuildContext context) {
    String email =
        'admin@gmail.com'; // Email del usuario administrador // Verificar si el usuario actual es administrador
    final isAdmin = FirebaseAuth.instance.currentUser?.email == email;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 224, 119, 208),
        // Aquí van los elementos del Drawer
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Aquí van los elementos del Drawer
            Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 100,
                  child: Image.asset(
                    'assets/images/logoqr2.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  child: const Text(
                    'Menú',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: const Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0),
                  ),
                  subtitle: Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
               ListTile(
  leading: const Icon(Icons.home), // Icono para Home
  title: const Text('Home'),
  onTap: () {
    if (FirebaseAuth.instance.currentUser?.email == 'admin@gmail.com') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuAdmin(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const StudentInformation(),
        ),
      );
    }
  },
),

                if (isAdmin) // Solo muestra la opción si el usuario es administrador
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Registro de usuario'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Historial de Accesos'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccessHistory()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Información de la App'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Centro de Ayuda'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpCenterScreen()),
                    );
                  },
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Cerrar Sesión'),
                  onTap: () {
                    // Acción para cerrar sesión
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LoginScreen()), // Reemplaza LoginScreen con el nombre de tu pantalla de inicio de sesión
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Información del Estudiante',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 119, 208),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error al cargar los datos del estudiante.'),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.data() == null) {
                    return const Center(
                      child:
                          Text('No se encontraron datos para este estudiante.'),
                    );
                  }

                  final userData = snapshot.data!.data()!;

                  // Texto que se utilizará para generar el código QR
                  String qrData =
                      '${userData['firstName']} ${userData['lastName']}, ${userData['registration']}, ${userData['career']}, ${userData['gender']}';

                  return Column(
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10.0),
                              child: Text(
                                'Detalles del Estudiante',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text(
                                'Nombre(s):',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              subtitle: Text(
                                '${userData['firstName']} ${userData['lastName']}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text(
                                'Matrícula:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              subtitle: Text(
                                userData['registration'],
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text(
                                'Carrera:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              subtitle: Text(
                                userData['career'],
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text(
                                'Género:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              subtitle: Text(
                                userData['gender'],
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                            const SizedBox(
                                height:
                                    10.0), // Añadimos espacio adicional al final
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Código QR',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            QrImageView(
                              data: qrData,
                              version: QrVersions.auto,
                              size: 260.0,
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
