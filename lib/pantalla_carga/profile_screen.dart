import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:securepassqr/pantalla_carga/about_screen.dart';
import 'package:securepassqr/pantalla_carga/accesshistory_screen.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';
import 'package:securepassqr/pantalla_carga/student_information.dart';
import 'package:securepassqr/pantalla_carga/view_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _selectedUserId = '';
  late User _currentUser;
  String _firstName = '';
  String _lastName = '';
  String _career = '';
  String _registration = '';
  String _gender = ''; // Nuevo campo agregado

  List<String> _userIds = [];

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser!;
    _loadUserData();
    _fetchUserIds();
  }

  Future<void> _loadUserData() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(_currentUser.uid).get();
    final userData = snapshot.data();
    if (userData != null) {
      setState(() {
        _firstName = userData['firstName'] ?? '';
        _lastName = userData['lastName'] ?? '';
        _career = userData['career'] ?? '';
        _registration = userData['registration'] ?? '';
        _gender = userData['gender'] ?? ''; // Actualiza el género del usuario
      });
    }
  }

  Future<void> _saveUserData() async {
    if (_selectedUserId.isNotEmpty) {
      await _firestore.collection('users').doc(_selectedUserId).set({
        'firstName': _firstName,
        'lastName': _lastName,
        'career': _career,
        'registration': _registration,
        'gender': _gender, // Guarda también el género del usuario
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seleccione un usuario para guardar la información.'),
        ),
      );
    }
  }

  Future<void> _fetchUserIds() async {
    final users = await _firestore.collection('users').get();
    setState(() {
      _userIds = users.docs.map((doc) => doc.id).toList();
    });
  }

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
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: _selectedUserId.isNotEmpty ? _selectedUserId : null,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedUserId = newValue ?? '';
                    _loadUserData();
                  });
                },
                items: _userIds.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _firstName,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _firstName = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _lastName,
              decoration: const InputDecoration(
                labelText: 'Apellido',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _lastName = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _career,
              decoration: const InputDecoration(
                labelText: 'Carrera',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _career = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _registration,
              decoration: const InputDecoration(
                labelText: 'Matrícula',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _registration = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _gender,
              decoration: const InputDecoration(
                labelText: 'Género', // Etiqueta para el campo de género
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _gender = value, // Actualiza el género
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUserData,
              child: const Text('Guardar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewProfileScreen(userId: _selectedUserId),
                  ),
                );
              },
              child: const Text('Ver Perfil'),
            )
          ],
        ),
      ),
    );
  }
}
