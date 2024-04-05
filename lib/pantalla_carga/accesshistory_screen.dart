import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:securepassqr/pantalla_carga/about_screen.dart';
import 'package:securepassqr/pantalla_carga/helpcanter_screen.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';
import 'package:securepassqr/pantalla_carga/profile_screen.dart';
import 'package:securepassqr/pantalla_carga/student_information.dart';

class AccessHistory extends StatefulWidget {
  const AccessHistory({Key? key}) : super(key: key);

  @override
  _AccessHistoryState createState() => _AccessHistoryState();
}

class _AccessHistoryState extends State<AccessHistory> {
  @override
  void initState() {
    super.initState();
    addAccessToHistory(); // Llama automáticamente a la función cuando se crea el widget
  }

  void addAccessToHistory() async {
    try {
      // Obtener la referencia al documento del usuario actual
      final userDocRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);

      // Obtener la ubicación actual
      String location = await getLocation();

      // Verificar si el usuario es administrador
      String email = 'admin@gmail.com'; // Email del usuario administrador
      if (FirebaseAuth.instance.currentUser!.email == email) {
        // Agregar usuario a la colección admin_user si es administrador
        FirebaseFirestore.instance.collection('admin_user').doc(FirebaseAuth.instance.currentUser!.uid).set({
          'email': FirebaseAuth.instance.currentUser!.email,
          // Puedes agregar más información aquí si lo deseas
        });

        // Agregar una subcolección llamada 'access_history' al documento del usuario administrador
        final adminAccessHistoryRef = FirebaseFirestore.instance.collection('admin_user').doc(FirebaseAuth.instance.currentUser!.uid).collection('access_history');

        // Agregar información a la subcolección
        adminAccessHistoryRef.add({
          'date': DateTime.now(), // Fecha actual
          'location': location,
        });
      } else {
        // Agregar una subcolección llamada 'access_history' al documento del usuario
        final accessHistoryRef = userDocRef.collection('access_history');

        // Agregar información a la subcolección
        accessHistoryRef.add({
          'date': DateTime.now(), // Fecha actual
          'location': location,
        });
      }

      print('Acceso registrado en el historial.');
    } catch (error) {
      print('Error al registrar el acceso: $error');
    }
  }

  // Esta función devuelve la ubicación actual del dispositivo
  Future<String> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return 'Lat: ${position.latitude}, Long: ${position.longitude}';
    } catch (e) {
      return 'No se pudo obtener la ubicación: $e';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  title: const Text(
                    '',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10.0),
                  ),
                  subtitle: Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const StudentInformation()),
                    );
                  },
                ),
                if (isAdmin)
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Registrar Usuario'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Historial de Accesos'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AccessHistory()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Información de la App'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Centro de Ayuda'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Historial de Accesos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: isAdmin ?
          FirebaseFirestore.instance
            .collection('admin_user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('access_history')
            .orderBy('date', descending: true)
            .snapshots() :
          FirebaseFirestore.instance
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
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final access = documents[index];
              final date = access['date'].toDate();
              return ListTile(
                title: Text('Fecha y Hora: ${DateFormat('yyyy-MM-dd HH:mm').format(date)}'),
                subtitle: Text('Ubicación: ${access['location']}'),
              );
            },
          );
        },
      ),
    );
  }
}
