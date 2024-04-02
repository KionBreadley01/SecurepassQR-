import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:securepassqr/pantalla_carga/about_screen.dart';
import 'package:securepassqr/pantalla_carga/accesshistory_screen.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';
import 'package:securepassqr/pantalla_carga/profile_screen.dart';
import 'package:securepassqr/pantalla_carga/student_information.dart';

class ViewProfileScreen extends StatelessWidget {
  final String userId;

  const ViewProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = 'admin@gmail.com'; // Email del usuario administrador // Verificar si el usuario actual es administrador
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
                    'Menu',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ), 
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const StudentInformation()),
                    );  
                  },
                ),
                if (isAdmin) // Solo muestra la opción si el usuario es administrador
                  ListTile(
                    title: const Text('registrar usuario'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProfileScreen()),
                      );
                    },
                  ),
                ListTile(
                  title: const Text('Historial de accesos'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AccessHistory()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Acerca de'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AboutScreen()),
                    ); 
                    // Acción para mostrar información sobre la aplicación
                    // Puedes implementar aquí la lógica para mostrar una pantalla con información sobre la aplicación
                  },
                ),
                ListTile(
                  title: const Text('Problemas con mi información'),
                  onTap: () {
                    // Acción para mostrar información sobre la aplicación
                    // Puedes implementar aquí la lógica para mostrar una pantalla con información sobre la aplicación
                  },
                ),
                ListTile(
                  title: const Text('XD'),
                  onTap: () {
                    // Acción para mostrar información sobre la aplicación
                    // Puedes implementar aquí la lógica para mostrar una pantalla con información sobre la aplicación
                  },
                ),
              ],
            ),
            Column(
              children: [
                // Aquí van los elementos del Drawer que quieras en la parte inferior
                ListTile(
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
      
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar los datos del usuario.'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return const Center(
              child: Text('No se encontraron datos para este usuario.'),
            );
          }

          final userData = snapshot.data!.data()!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ${userData['firstName']} ${userData['lastName']}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Carrera: ${userData['career']}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Matrícula: ${userData['registration']}',
                  style: const TextStyle(fontSize: 16),
                ),
                 const SizedBox(height: 8),
                Text(
                  'Genero: ${userData['gender']}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
