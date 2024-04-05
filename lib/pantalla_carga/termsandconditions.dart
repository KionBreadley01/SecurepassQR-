import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Políticas y Condiciones',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 119, 208),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Términos y Condiciones',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Alumnos de la institución educativa:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Los alumnos de la institución educativa están bajo su propio riesgo de compartir su información con terceros o personas que no sean miembros autorizados del personal educativo. No nos hacemos responsables del uso indebido de la información compartida por los alumnos con terceros.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Manejo de la información:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  '1. Recopilamos y almacenamos información personal de los usuarios con el propósito de mejorar la experiencia del usuario y proporcionar servicios personalizados.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '2. Utilizamos medidas de seguridad adecuadas para proteger la información del usuario contra accesos no autorizados o divulgación.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '3. No compartimos la información del usuario con terceros sin su consentimiento, excepto cuando sea requerido por la ley.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '4. Los usuarios tienen derecho a acceder, rectificar y eliminar su información personal según lo establecido por las leyes de protección de datos aplicables.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '5. Podemos utilizar la información del usuario para fines de análisis y mejora de nuestros servicios, siempre protegiendo la privacidad del usuario.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Al utilizar nuestra aplicación, usted acepta estos términos y condiciones. Si no está de acuerdo con estos términos, por favor no utilice nuestra aplicación.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
