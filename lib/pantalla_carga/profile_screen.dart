import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:securepassqr/pantalla_carga/about_screen.dart';
import 'package:securepassqr/pantalla_carga/accesshistory_screen.dart';
import 'package:securepassqr/pantalla_carga/helpcanter_screen.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';
import 'package:securepassqr/pantalla_carga/signup_screen.dart';
import 'package:securepassqr/pantalla_carga/student_information.dart';
import 'package:securepassqr/pantalla_carga/view_profile.dart';
import 'package:securepassqr/pantalla_carga/Menuadmin_screen.dart';
import 'package:securepassqr/pantalla_carga/viewhistory.dart';

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
    if (_areFieldsFilled()) {
      if (_selectedUserId.isNotEmpty) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _firestore.collection('users').doc(_selectedUserId).get();
        final userData = snapshot.data();

        if (userData != null) {
          final Map<String, dynamic> updatedData = {
            if (_firstName.isNotEmpty) 'firstName': _firstName,
            if (_lastName.isNotEmpty) 'lastName': _lastName,
            if (_career.isNotEmpty) 'career': _career,
            if (_registration.isNotEmpty) 'registration': _registration,
            if (_gender.isNotEmpty) 'gender': _gender,
            'email':
                userData['email'], // Mantener el correo electrónico sin cambios
          };

          await _firestore
              .collection('users')
              .doc(_selectedUserId)
              .update(updatedData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Se ha guardado la información')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Por favor seleccione un usuario para guardar la información.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Por favor complete todos los campos antes de guardar la información.')),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se ha eliminado la información')),
      );
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

  bool _areFieldsFilled() {
    return _firstName.isNotEmpty &&
        _lastName.isNotEmpty &&
        _career.isNotEmpty &&
        _registration.isNotEmpty &&
        _gender.isNotEmpty;
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
          'Gestión de Usuarios',
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
                'Por favor, elija un correo electrónico para poder ver su información, realizar modificaciones, guardar cambios, eliminar datos y revisar su historial de accesos',
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
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[a-zA-Z ]{1,30}$')),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _lastName,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _lastName = value,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[a-zA-Z ]{1,30}$')),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _career,
                decoration: const InputDecoration(
                  labelText: 'Carrera',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _career = value,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[a-zA-Z0-9 ]{1,25}$')),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _registration,
                decoration: const InputDecoration(
                  labelText: 'Matrícula',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _registration = value,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[a-zA-Z0-9]{1,25}$')),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender.isNotEmpty ? _gender : null,
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue ?? '';
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Género',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Femenino',
                    child: Text('Femenino'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Masculino',
                    child: Text('Masculino'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Indistinto',
                    child: Text('Indistinto'),
                  ),
                ],
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Por favor seleccione un usuario para ver el perfil.')),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Por favor seleccione un usuario para eliminar los datos.')),
                        );
                      }
                    },
                    child: const Text('Eliminar Datos'),
                  ),
                  const SizedBox(width: 20), // Espacio entre botones
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedUserId.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewHistory(userId: _selectedUserId),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Por favor seleccione un usuario para ver el historial de accesos.')),
                        );
                      }
                    },
                    child: const Text('Ver Historial'),
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
