import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:securepassqr/pantalla_carga/about_screen.dart';
import 'package:securepassqr/pantalla_carga/helpcanter_screen.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';
import 'package:securepassqr/pantalla_carga/menuadmin_screen.dart';
import 'package:securepassqr/pantalla_carga/profile_screen.dart';
import 'package:securepassqr/pantalla_carga/signup_screen.dart';
import 'package:securepassqr/pantalla_carga/student_information.dart';

class ViewHistory extends StatelessWidget {
  final String userId;

  const ViewHistory({Key? key, required this.userId}) : super(key: key);

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
                    if (FirebaseAuth.instance.currentUser?.email ==
                        'admin@gmail.com') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MenuAdmin(), // Reemplaza MenuAdmin con el nombre de tu pantalla para administradores
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
                    title: const Text('Regritro de usuarios'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()),
                      );
                    },
                  ),
                if (isAdmin) // Solo muestra la opción si el usuario es administrador
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Gestión de Usuarios'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
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
          'Historial de Accesos ',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 119, 208),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 8.0),
            child: const Text(
              'Por favor, regrese a la pestaña de Historial de Accesos si no se han registrado nuevas entradas.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: isAdmin
            ? FirebaseFirestore.instance
                .collection('admin_user')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('access_history')
                .orderBy('date', descending: true)
                .snapshots()
            : FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('access_history')
                .orderBy('date', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar el historial de accesos.'),
            );
          }
          final documents = snapshot.data!.docs;
          Map<DateTime, List<DocumentSnapshot>> groupedByDate =
              groupByDate(documents);

          return ListView.builder(
            itemCount: groupedByDate.length,
            itemBuilder: (context, index) {
              DateTime date = groupedByDate.keys.elementAt(index);
              List<DocumentSnapshot> accesses = groupedByDate[date]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat('yyyy-MM-dd').format(date),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: accesses.length,
                    itemBuilder: (context, index) {
                      final access = accesses[index];
                      final date = access['date'].toDate();
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(
                              'Fecha y Hora: ${DateFormat('yyyy-MM-dd HH:mm').format(date)}'),
                          subtitle: Text('Ubicación: ${access['location']}'),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Map<DateTime, List<DocumentSnapshot>> groupByDate(
      List<DocumentSnapshot> documents) {
    Map<DateTime, List<DocumentSnapshot>> groupedByDate = {};

    documents.forEach((document) {
      DateTime date = (document['date'] as Timestamp).toDate();
      DateTime dateWithoutTime = DateTime(date.year, date.month, date.day);

      if (!groupedByDate.containsKey(dateWithoutTime)) {
        groupedByDate[dateWithoutTime] = [];
      }

      groupedByDate[dateWithoutTime]!.add(document);
    });

    return groupedByDate;
  }
}
