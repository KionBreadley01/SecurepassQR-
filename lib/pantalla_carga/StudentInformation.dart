import 'package:flutter/material.dart';

class StudentInformation extends StatelessWidget {
  const StudentInformation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Información del estudiante',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Nombre(s)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                subtitle: Text('Juan Manuel', style: TextStyle(fontSize: 14.0)),
              ),
               Divider(color: Colors.grey),
              ListTile(
                title: Text(
                  'Apellido(s)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                subtitle: Text('Hernandez Sanchez', style: TextStyle(fontSize: 14.0)),
              ),
               Divider(color: Colors.grey),
              ListTile(
                title: Text(
                  'Matricula',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                subtitle: Text('dndn3n: n4n4m5', style: TextStyle(fontSize: 14.0)),
              ),
               Divider(color: Colors.grey),
              ListTile(
                title: Text(
                  'Carrera',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                subtitle: Text('TIADSM', style: TextStyle(fontSize: 14.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 