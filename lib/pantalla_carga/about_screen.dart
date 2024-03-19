import 'package:flutter/material.dart';
import 'package:securepassqr/pantalla_carga/accesshistory_screen.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';
import 'package:securepassqr/pantalla_carga/student_information.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    // Acción para mostrar información sobre la aplicación
                    // Puedes implementar aquí la lógica para mostrar una pantalla con información sobre la aplicación
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
                 // Aquí van los elementos del Drawer que quieras en la parte superior
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
        title: const Text('Acerca de',
           style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
           backgroundColor: const Color.fromARGB(255, 224, 119, 208),
      ),
      body: Padding(
        padding: const  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Image.asset(
                    'assets/images/logoqr.png',
                    fit: BoxFit.scaleDown,
                    width: 200,
                    height: 100,
                  ),  
            const  SizedBox(height: 20.0),

           const  Text(
              '',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          const    SizedBox(height: 10.0),
          const   Text(
              'Versión: 2.0.0 Aqua ' ,
              style: TextStyle(fontSize: 18.0),
            ),
            const  SizedBox(height: 10.0),
           const  Text(
              'Desarrollado por: KionBredley',
              style: TextStyle(fontSize: 18.0),
            ),
            const  SizedBox(height: 10.0),
          const   Text(
              'Descripción: SecurePassQR es una aplicación diseñada para  registrar el acceso de los usuarios de una institución academica .',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

