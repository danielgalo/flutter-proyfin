import 'package:flutter/material.dart';
import 'package:flutter_proyfin_dgv/pantallas/pantalla_inicio.dart';
import 'package:flutter_proyfin_dgv/persistencia/datos_entrenamiento.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  // Iniciar Hive
  await Hive.initFlutter();
  // Abrir una box de hive (La Base de Datos)
  await Hive.openBox("bbdd");


  runApp(const MyApp());
}

/// Clase principal, lanza la pantalla de inicio
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatosEntrenamiento(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PantallaInicio(),
      ),
    );
  }
}
