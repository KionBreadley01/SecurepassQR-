import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // Importa la biblioteca intl para DateFormat
import 'package:geolocator/geolocator.dart';

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
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);

      // Agregar una subcolección llamada 'access_history' al documento del usuario
      final accessHistoryRef = userDocRef.collection('access_history');

      // Obtener la ubicación actual
      String location = await getLocation();

      // Agregar información a la subcolección
      accessHistoryRef.add({
        'date': DateTime.now(), // Fecha actual
        'location': location,
      });

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Accesos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('access_history')
            .orderBy('date', descending: true) // Ordenar por fecha descendente
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
