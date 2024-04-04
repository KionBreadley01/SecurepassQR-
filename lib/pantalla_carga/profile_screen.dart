import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:securepassqr/pantalla_carga/about_screen.dart';
import 'package:securepassqr/pantalla_carga/accesshistory_screen.dart';
import 'package:securepassqr/pantalla_carga/helpcanter_screen.dart';
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
  String _gender = '';

  List<String> _userIds = [];
  Map<String, String> _userEmails = {};

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
        _gender = userData['gender'] ?? '';
      });
    }
  }

  Future<void> _saveUserData() async {
    if (_selectedUserId.isNotEmpty) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(_selectedUserId).get();
      final userData = snapshot.data();

      if (userData != null) {
        final Map<String, dynamic> updatedData = {
          'firstName':
              _firstName.isNotEmpty ? _firstName : userData['firstName'],
          'lastName': _lastName.isNotEmpty ? _lastName : userData['lastName'],
          'career': _career.isNotEmpty ? _career : userData['career'],
          'registration': _registration.isNotEmpty
              ? _registration
              : userData['registration'],
          'gender': _gender.isNotEmpty ? _gender : userData['gender'],
          'email':
              userData['email'], // Mantener el correo electrónico sin cambios
        };

        await _firestore
            .collection('users')
            .doc(_selectedUserId)
            .update(updatedData);
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Aviso'),
            content: const Text(
                'Por favor seleccione un usuario para guardar la información.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _deleteUserData() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(_selectedUserId).get();
    final userData = snapshot.data();

    if (userData != null) {
      final Map<String, dynamic> updatedData = {
        'firstName': '',
        'lastName': '',
        'career': '',
        'registration': '',
        'gender': '',
        'email':
            userData['email'], // Mantener el correo electrónico sin cambios
      };

      await _firestore
          .collection('users')
          .doc(_selectedUserId)
          .update(updatedData);
    }
  }

  Future<void> _fetchUserIds() async {
    final users = await _firestore.collection('users').get();
    setState(() {
      _userIds = users.docs.map((doc) => doc.id).toList();
      _userEmails = Map.fromIterable(users.docs,
          key: (doc) => doc.id, value: (doc) => doc.data()?['email'] ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    String email = 'admin@gmail.com';
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
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: const Text(
                    '',
                    style: 
                        TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10.0),
                  ),
                  subtitle: Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: const TextStyle( color: Colors.black ,fontSize: 16.0),
                    textAlign: TextAlign.center,
                    
                  ),
                ),
                ListTile(
                    leading: const Icon(Icons.home), // Icono para Home
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentInformation()),
                    );
                  },
                ),
                if (isAdmin) // Solo muestra la opción si el usuario es administrador
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Registrar Usuario'),
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
          'Perfil de Usuario',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 119, 208),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seleciones le correo recien registrado '
                'Recuerda que solo podras ver los correos de los usuarios registrados',
                style: TextStyle(fontSize: 16.0),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 224, 119, 208),
                      width: 2),
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
                      child: Text(_userEmails[value] ?? ''),
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
                  labelText: 'Género',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _gender = value,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedUserId.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewProfileScreen(userId: _selectedUserId),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Aviso'),
                              content: const Text(
                                  'Por favor seleccione un usuario para ver el perfil.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Ver Perfil'),
                  ),
                  const SizedBox(width: 20), // Espacio entre botones
                  ElevatedButton(
                    onPressed: _saveUserData,
                    child: const Text('Guardar'),
                  ),
                  const SizedBox(width: 20), // Espacio entre botones
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedUserId.isNotEmpty) {
                        _deleteUserData();
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Aviso'),
                              content: const Text(
                                  'Por favor seleccione un usuario para eliminar los datos.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Eliminar Datos'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
