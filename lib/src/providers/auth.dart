// //HACK: SI ALGO SALE MAL ES TAL VEZ POR ESTO: ignore_for_file: use_build_context_synchronously.

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:securepassqr/src/providers/user.dart';

// /// [AuthService] - Clase que maneja la autenticación del usuario.
// /// Utiliza FirebaseAuth para interactuar con Firebase Authentication.
// class AuthService with ChangeNotifier {
//   ///NOTE: Evaluamos el estado del usuario mediante esta clase. Ademas que aqui declaramos todo lo que ocuparemos en las otras clases

//   /// FIREBASEUSER [firebaseUser] - Mediante una instancia a la clase User,
//   User? firebaseUser = FirebaseAuth.instance.currentUser;

//   /// IMAGEPATH [imagePath] - Devuelve la ruta de la imagen del usuario
//   final Reference _imageRef = FirebaseStorage.instance.ref();

//   /// AUTH [_auth] - Devuelve la instancia de la autenticacion de usuario.
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   /// USER [_user] - Devuelve la instancia con la clase Users
//   late final Users _user = Users();

//   /// DB [_db] - Devuelve la instancia al firestore.
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   /// STATUS [_status] - Devuelve el estado en el que esta el usuario.
//   late AuthStatus _status = AuthStatus.Uninitialized;

//   /// Constructor privado
//   AuthService._private();

//   // Definición de instancia privada
//   static final AuthService _instancia = AuthService._private();

//   // Definición de factor de creacion de instancia
//   factory AuthService() {
//     _instancia.firebaseUser = FirebaseAuth.instance.currentUser;
//     _instancia._auth.authStateChanges().listen(_instancia._onAuthStateChanged);
//     _instancia.notifyListeners();
//     return _instancia;
//   }

//   /// Constructor de [AuthService] que inicia la escucha de los cambios de estado
//   ///  de autenticación.

//   /// Getters para obtener el estado de autenticación y los datos del usuario.
//   /// AUTH [auth] - Devuelve la instancia de la autenticacion de usuario.
//   FirebaseAuth get auth => _auth;

//   /// DB [db] - Devuelve la instancia al firestore.
//   FirebaseFirestore get db => _db;

//   /// IMAGEPATH [imagePath] - Devuelve la ruta de la imagen del usuario
//   Reference get imageRef => _imageRef;

//   /// STATUS [status] - Devuelve el estado en el que esta el usuario.
//   AuthStatus get status => _status;

//   /// USER [user] - Devuelve la instancia con la clase Users
//   Users get user => _user;

//   /// [signInWithEmailAndPassword] - Método para iniciar sesión con correo electrónico y contraseña.
//   /// Actualiza el estado de autenticación y notifica a los oyentes sobre el cambio de estado.
//   Future<User?> signInWithEmailAndPassword(
//       String email, String password) async {
//     _status = AuthStatus.Authenticating;
//     notifyListeners();
//     try {
//       UserCredential authResult = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       User user = authResult.user!;

//       DocumentSnapshot users =
//           await _db.collection('users').doc(user.uid).get();

//       Users currentUser = Users.fromFirestore(users);
//       currentUser;
//       notifyListeners();
//       //await updateUserData(user);

//       return user;
//     } catch (e) {
//       _status = AuthStatus.Unauthenticated;
//       notifyListeners();
//       return null;
//     }
//   }

//   /// [signOut] - Método para cerrar la sesión del usuario.
//   /// Actualiza el estado de autenticación y notifica a los oyentes sobre el cambio de estado.
//   void signOut() {
//     _auth.signOut();
//     _status = AuthStatus.Unauthenticated;
//     notifyListeners();
//   }

//   /// [updateUserData] - Método para actualizar los datos del usuario en Firestore.
//   /// Se utiliza después de un inicio de sesión exitoso para almacenar información relevante del usuario.
//   Future<DocumentSnapshot> updateUserData(User user) async {
//     DocumentReference userRef = _db.collection('Alumnos').doc(user.uid);
//     userRef.set({
//       'idalumnos': userRef,
//       'Correo': user.email,
//       'lastSign': DateTime.now(),
//       //'photoURL': user.photoURL,
//       'Nombre': user.displayName
//     }, SetOptions(merge: true));
//     DocumentSnapshot userData = await userRef.get();
//     return userData;
//   }

//   /// [_onAuthStateChanged] - Método que se llama cada vez que el estado de autenticación cambia.
//   /// Actualiza el estado interno de [AuthService] y notifica a los oyentes sobre el cambio.
//   Future<void> _onAuthStateChanged(User? user) async {
//     if (user == null) {
//       _status = AuthStatus.Unauthenticated;
//     } else {
//       DocumentSnapshot userSnap =
//           await _db.collection('Alumnos').doc(user.uid).get();
//       _user.setFromFireStore(userSnap);
//       _status = AuthStatus.Authenticated;
//     }
//     notifyListeners();
//   }
// }

// /// [AuthStatus] - Se almacenará los estados del usuario.
// ///
// /// [Uninitialized] - Es el estado del usuario cuando no está inicializado.
// /// Cuando abres la aplicación y no sabemos si está autenticado.
// ///
// /// [Authenticated] - Es cuando el usuario ya está autenticado o inició sesión.
// ///
// /// [Authenticating] - Es cuando se está en el proceso de autenticación entre
// /// la aplicación y Firebase.
// ///
// /// [Unauthenticated] - Cuando no ha iniciado sesión. Importante para saber decidir si el usuario
// /// podrá pasar de una pantalla a otra.
// enum AuthStatus {
//   Uninitialized,
//   Authenticated,
//   Authenticating,
//   Unauthenticated
// }