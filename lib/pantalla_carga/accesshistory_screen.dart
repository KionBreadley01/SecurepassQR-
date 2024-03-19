import 'package:flutter/material.dart';
// import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:securepassqr/pantalla_carga/about_screen.dart';
import 'package:securepassqr/pantalla_carga/login_screen.dart';
import 'package:securepassqr/pantalla_carga/student_information.dart';

class AccessHistory extends StatefulWidget {
  const AccessHistory({Key? key}) : super(key: key);

  @override
  _AccessHistoryState createState() => _AccessHistoryState();
}

class _AccessHistoryState extends State<AccessHistory> {
  late List<Map<String, dynamic>> accessRecords;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchAccessRecords();
  // }

  // Future<void> fetchAccessRecords() async {
  //   final db = mongo.Db('mongodb+srv://juansanchezjuan125:Don_gato01@clusteruwu.znjsusx.mongodb.net/');
  //   await db.open();
  //   final collection = db.collection('alumnos');
  //   final records = await collection.find().toList();
  //   setState(() {
  //     accessRecords = records.map((record) => record as Map<String, dynamic>).toList();
  //   });
  //   await db.close();
  // }

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
        title: const Text('Historial de accesos'),
      ),
      // body: accessRecords.isNotEmpty
      //     && accessRecords[0].containsKey('location')
      //     && accessRecords[0].containsKey('date')
      //     && accessRecords[0].containsKey('time')
      //     ? ListView.builder(
      //         itemCount: accessRecords.length,
      //         itemBuilder: (context, index) {
      //           final record = accessRecords[index];
      //           return ListTile(
          //         title: Text('Ubicación: ${record['location']}'),
          //         subtitle: Text('Fecha: ${record['date']}, Hora: ${record['time']}'),
          //       );
          //     },
          //   )
          // : const Center(
//           //     child: CircularProgressIndicator(),
//             ),
//     );
//   }
// }
    );
  }
}