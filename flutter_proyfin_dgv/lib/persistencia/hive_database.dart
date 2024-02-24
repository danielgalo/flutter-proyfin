import 'package:flutter_proyfin_dgv/fechas/fecha_hora.dart';
import 'package:flutter_proyfin_dgv/modelos/ejercicio.dart';
import 'package:flutter_proyfin_dgv/modelos/entrenamiento.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Clase para manejar la base de datos
class HiveDatabase {
  // Referenciar la box de Hive
  final _myBox = Hive.box("bbdd");

  // Comprobar si hay datos guardados, si no, guardar la fecha de inicio
  bool existenDatosPrevios() {
    if (_myBox.isEmpty) {
      _myBox.put("FECHA_INICIO", fechaHoy());
      return false;
    } else {
      return true;
    }
  }

  // devolver fecha de inicio
  String getFechaInicio() {
    return _myBox.get("FECHA_INICIO");
  }

  // Escribir informacion
  void guardarEnBD(List<Entrenamiento> entrenamientos) {
    // Convertir lista de entrenamientos en lista de string,
    // Ya que Hive no soporta objetos que no sean primitivos
    final listaEntrenamientos = objetoToListaEntrenamientos(entrenamientos);
    final listaEjercicios = objetoToListaEjercicios(entrenamientos);

    // Comprobar si los ejercicios están terminados, se pondrá un 0 o un 1 en cada fecha dependiendo si está terminado o no
    if (ejercicioCompletado(entrenamientos)) {
      _myBox.put("ESTADO_FINALIZACIÓN_${fechaHoy()}", 1);
    } else {
      _myBox.put("ESTADO_FINALIZACIÓN_${fechaHoy()}", 0);
    }

    // Guardar en la bbdd
    _myBox.put("ENTRENAMIENTOS", listaEntrenamientos);
    _myBox.put("EJERCICIOS", listaEjercicios);
  }

  /// Obtiene true si al menos un ejercicio dentro de la lista de entrenamientos está terminado
  bool ejercicioCompletado(List<Entrenamiento> entrenamientos) {
    // Recorrer todos los entrenamientos
    for (var entrenamiento in entrenamientos) {
      // Recorrer todos los ejercicios de los entrenamientos
      for (var ejercicio in entrenamiento.ejercicios) {
        if (ejercicio.terminado) {
          return true;
        }
      }
    }

    return false;
  }

  /// Leer informacion y devolver lista de entrenamientos
  List<Entrenamiento> entrenamientosFromDataBase() {

    List<Entrenamiento> entrenamientosEncontrados = [];

    // Obtener entrenamientos y ejercicios
    List<String> nombreEntrenamientos = _myBox.get("ENTRENAMIENTOS");
    final detallesEjercicios = _myBox.get("EJERCICIOS");

    // Crear objetos entrenamiento, por cada entrenamiento
    for (int i = 0; i < nombreEntrenamientos.length; i++) {

      // Cada entrenamiento puede tener varios ejercicios
      List<Ejercicio> ejerciciosEnCadaEntreno = [];

      // Por cada detalle de ejercicio guardado en la bbdd en forma de array, crear un ejercicio
      for (int j = 0; j < detallesEjercicios[i].length; j++) {
        ejerciciosEnCadaEntreno.add(Ejercicio(
            nombre: detallesEjercicios[i][j][0],
            peso: detallesEjercicios[i][j][1],
            repeticiones: detallesEjercicios[i][j][2],
            series: detallesEjercicios[i][j][3],
            terminado: detallesEjercicios[i][j][4] == "true" ? true : false));
      }
      // Guardar los datos encontrados y añadirlo a la lista a devolver
      Entrenamiento entrenamiento = Entrenamiento(nombre: nombreEntrenamientos[i], ejercicios: ejerciciosEnCadaEntreno);
      entrenamientosEncontrados.add(entrenamiento);
    }
    return entrenamientosEncontrados;
  }

  /// Devolver el estado de completado de un ejercicio dado una fecha (0 si no está terminaod o es nulo o 1 si está terminado)
  int getEstadoDeFinalizacion(String date){
    int estadoFinalizacion = _myBox.get("ESTADO_FINALIZACIÓN_$date") ?? 0;
    return estadoFinalizacion;
  }


  /// convertir entrenamientos en una lista
  List<String> objetoToListaEntrenamientos(List<Entrenamiento> entrenamientos) {
    // Lista a devolver
    List<String> listaEntrenamientos = [];

    // Recorrer lista pasada, volcar los nombres del entrenamiento a la lista a devolver
    for (int i = 0; i < entrenamientos.length; i++) {
      listaEntrenamientos.add(entrenamientos[i].nombre);
    }

    return listaEntrenamientos;
  }

  /// Convierte ejercicios en una lista de cadenas.
  /// Es una Lista, la cual contiene una lista de entrenamientos,
  /// los cuales tienen una lista de ejercicios, de los que se guardará una cadena
  List<List<List<String>>> objetoToListaEjercicios(
      List<Entrenamiento> entrenamientos) {
    // Lista a devolver
    List<List<List<String>>> listaEjericios = [];

    for (int i = 0; i < entrenamientos.length; i++) {
      // Obtener ejercicios por cada entrenamiento
      List<Ejercicio> ejerciciosEnEntrenamiento = entrenamientos[i].ejercicios;

      List<List<String>> entrenamientoIndividual = [
        // Pecho:
        // [[ Press banca, 60KG, 10 repeticiones, 3 series], [Triceps, 10KG, 12 repeticiones, 4 series]]
        // ...
      ];

      // Por cada ejercicio del entrenamiento
      for (int j = 0; j < ejerciciosEnEntrenamiento.length; j++) {
        List<String> ejercicioIndividual = [
          // [ Press banca, 60KG, 10 repeticiones, 3 series] ...
        ];
        ejercicioIndividual.addAll([
          ejerciciosEnEntrenamiento[j].nombre,
          ejerciciosEnEntrenamiento[j].peso,
          ejerciciosEnEntrenamiento[j].repeticiones,
          ejerciciosEnEntrenamiento[j].series,
          ejerciciosEnEntrenamiento[j].terminado.toString(),
        ]);
        entrenamientoIndividual.add(ejercicioIndividual);
      }
      listaEjericios.add(entrenamientoIndividual);
    }

    return listaEjericios;
  }
}
