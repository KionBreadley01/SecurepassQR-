import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StudentInformation extends StatelessWidget {
  const StudentInformation({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Datos del estudiante
    String nombre = 'Juan Manuel';
    String matricula = '20221DGS009';

    // Texto que se utilizará para generar el código QR
    String qrData = '$nombre, $matricula';

    return Scaffold(
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
                 const   Divider(),
                    ListTile(
                      title: const Text(
                        'Nombre(s):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      subtitle: Text(nombre, style: const TextStyle(fontSize: 16.0)), 
                    ),
                   const Divider(),
                  const  ListTile(
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
                  const  ListTile(
                      title: Text(
                        'Género:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      subtitle: Text('Masculino', style: TextStyle(fontSize: 16.0)),
                    ),
                  const   SizedBox(height: 10.0), // Añadimos espacio adicional al final
                  ],
                ),
              ),
            const  SizedBox(height: 20.0),
              Center(
                child: Column(
                  children: [
                   const  Text(
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
                      size: 200.0,
                    ),
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