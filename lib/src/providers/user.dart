// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Users with ChangeNotifier {
//   String? apellido;
//   String? carrera ;
//   String? contrasena;
//   String? correo;
//   String? fecha;
//   String? genero;
//   String? hora;
//   String? matricula;
//   String? nombre;
//   String _messagesLogin = '';

//   String get messagesLogin => _messagesLogin;

//   set messagesLogin(String value) {
//     _messagesLogin = value;
//     notifyListeners();
//   }


//    Users({
//     this.apellido,
//     this.carrera,
//     this.contrasena,
//     this.correo,
//     this.fecha,
//     this.genero,
//     this.hora,
//     this.matricula,
//     this.nombre,
//   });


//   factory Users.fromFirestore(DocumentSnapshot userDoc) {
//     Map<String, dynamic> json = userDoc.data() as Map<String, dynamic>;
//     return Users(
//       apellido: json['apellido'],
//       carrera: json['carrera'],
//       contrasena: json['contrasena'],
//       correo: json['correo'],
//       fecha: json['fecha'],
//       genero: json['genero'],
//       hora: json['hora'],
//       matricula: json['matricula'],
//       nombre: json['nombre'],
//     );
//   }
//   void setFromFireStore(DocumentSnapshot userDoc) {
//     Map<String, dynamic> json = userDoc.data() as Map<String, dynamic>;
//     apellido = json['apellido'];
//     carrera = json['carrera'];
//     contrasena = json['contrasena'];
//     correo = json['correo'];
//     fecha = json['fecha'];
//     genero = json['genero'];
//     hora = json['hora'];
//     matricula = json['matricula'];
//     nombre = json['nombre'];

//     notifyListeners();
//   }  
// }