import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:securepassqr/pantalla_carga/about_screen.dart';
import 'package:securepassqr/pantalla_carga/accesshistory_screen.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';

class StudentInformation extends StatelessWidget {
  const StudentInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Datos del estudiante
    String nombre = 'Juan Manuel';
    String matricula = '20221DGS009';
    //video para el trole de mañana despues quitalo
    String videoUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';

    // Texto que se utilizará para generar el código QR
    // String qrData = '$nombre, $matricula, $videoUrl';
    String qrData = '    $videoUrl';

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
                ),// Aquí van los elementos del Drawer que quieras en la parte superior
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
        title: const Text(
          'Información del Estudiante',
          style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 119, 208),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      subtitle: Text(nombre, style: const TextStyle(fontSize: 16.0)),
                    ),
                    const Divider(),
                    const ListTile(
                      title: Text(
                        'Apellido(s):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      subtitle: Text('Hernandez Sanchez', style: TextStyle(fontSize: 16.0)),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text(
                        'Matrícula:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      subtitle: Text(matricula, style:const TextStyle(fontSize: 16.0)),
                    ),
                    const Divider(),
                    const ListTile(
                      title:  Text(
                        'Carrera:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      subtitle: Text('TIADSM', style: TextStyle(fontSize: 16.0)),
                    ),
                    const Divider(),
                    const ListTile(
                      title: Text(
                        'Género:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      subtitle: Text('Masculino', style: TextStyle(fontSize: 16.0)),
                    ),
                    const SizedBox(
                        height: 10.0), // Añadimos espacio adicional al final
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
                    const SizedBox(height: 100.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

