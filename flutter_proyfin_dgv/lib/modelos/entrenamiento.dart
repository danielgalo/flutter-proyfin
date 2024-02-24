import 'package:flutter_proyfin_dgv/modelos/ejercicio.dart';

/// Entidad entrenamiento
class Entrenamiento{
  /// Nombre
  final String nombre;
  /// Ejercicios del entrenamiento
  final List<Ejercicio> ejercicios;

  Entrenamiento({required this.nombre, required this.ejercicios});
}