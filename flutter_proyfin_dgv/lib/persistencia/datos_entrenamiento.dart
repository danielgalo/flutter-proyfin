import 'package:flutter/material.dart';
import 'package:flutter_proyfin_dgv/fechas/fecha_hora.dart';
import 'package:flutter_proyfin_dgv/modelos/ejercicio.dart';
import 'package:flutter_proyfin_dgv/modelos/entrenamiento.dart';
import 'package:flutter_proyfin_dgv/persistencia/hive_database.dart';

/// Clase que almacena datos de entrenamientos
class DatosEntrenamiento extends ChangeNotifier {
  final db = HiveDatabase();

// Ejemplo
  List<Entrenamiento> entrenamientos = [];

  /// Si ya hay entrenamientos en la base de datos, devuelve la lista de entrenamientos existentes,
  /// si no, usar entrenamientos por defecto
  void iniciaListaEntrenamientos() {
    if (db.existenDatosPrevios()) {
      entrenamientos = db.entrenamientosFromDataBase();
    } else {
      // Si es la primera vez, carga datos de ejemplo
      entrenamientos.add(Entrenamiento(nombre: "Empuje", ejercicios: [
        Ejercicio(
            nombre: "Press Banca", peso: "50", repeticiones: "6", series: "3"),
      ]));
      entrenamientos.add(Entrenamiento(nombre: "Pull", ejercicios: [
        Ejercicio(nombre: "Remo", peso: "50", repeticiones: "6", series: "3"),
      ]));
      db.guardarEnBD(entrenamientos);
    }

    // Cargar heat map
    loadHeatMap();
  }

  /// Obtener lista de entrenamientos
  List<Entrenamiento> getListaEntrenamientos() {
    return entrenamientos;
  }

  /// Añadir entrenamiento
  void addEntrenamiento(String nombre) {
    entrenamientos.add(Entrenamiento(nombre: nombre, ejercicios: []));

    // Notificar para cambio de estado
    notifyListeners();
    db.guardarEnBD(entrenamientos);
    // Cargar heat map
    loadHeatMap();
  }

  /// Añadir ejercicios a entrenamiento
  void addEjercicio(String nombreEntrenamiento, String nombreEjercicio,
      String peso, String repeticiones, String series) {
    // Buscar el entrenamiento adecuado
    Entrenamiento entrenamientoAdecuado =
        getEntrenamientoByNombre(nombreEntrenamiento);

    entrenamientoAdecuado.ejercicios.add(Ejercicio(
        nombre: nombreEjercicio,
        peso: peso,
        repeticiones: repeticiones,
        series: series));

    // Notificar para cambio de estado
    notifyListeners();
    db.guardarEnBD(entrenamientos);
  }

  /// Obtener el número de ejercicios de un entrenamiento
  int getEjerciciosDeEntrenamiento(String nombreEntrenamiento) {
    // Buscar el entrenamiento y devolver su longitud
    Entrenamiento entrenamientoEncontrado =
        getEntrenamientoByNombre(nombreEntrenamiento);

    return entrenamientoEncontrado.ejercicios.length;
  }

  /// Termina un ejercicio
  void terminaEjercicio(String nombreEntrenamiento, String nombreEjercicio) {
    // Busca el ejercicio a terminar
    Ejercicio ejercicioEncontrado = getEjercicioByEntrenamientoAndNombre(
        nombreEntrenamiento, nombreEjercicio);

    // Lo termina
    ejercicioEncontrado.terminado = !ejercicioEncontrado.terminado;

    // Notificar para cambio de estado
    notifyListeners();
    db.guardarEnBD(entrenamientos);
    // Actualizar heat map
    loadHeatMap();
  }

  /// Obtener un entrenamiento por su nombre
  Entrenamiento getEntrenamientoByNombre(String nombreEntrenamiento) {
    // Buscar entrenamiento por su nombre
    Entrenamiento entrenamientoAdecuado = entrenamientos.firstWhere(
        (entrenamiento) => entrenamiento.nombre == nombreEntrenamiento);

    return entrenamientoAdecuado;
  }

  /// Obtener ejercicio por su nombre y nombre de su entrenamiento
  Ejercicio getEjercicioByEntrenamientoAndNombre(
      String nombreEntrenamiento, String nombreEjercicio) {
    // Busca el entrenamiento
    Entrenamiento entrenamientoEncontrado =
        getEntrenamientoByNombre(nombreEntrenamiento);
    // Dentro del entrenamiento, buscar el ejercicio
    Ejercicio ejercicioEncontrado = entrenamientoEncontrado.ejercicios
        .firstWhere((ejercicio) => ejercicio.nombre == nombreEjercicio);
    return ejercicioEncontrado;
  }

  Map<DateTime, int> hetMapDatos = {};

  /// Obtener fecha de inicio
  String getStartDate() {
    return db.getFechaInicio();
  }

  /// Cargar el mapa de seguimiento
  void loadHeatMap() {
    // Cargar fecha de inicio
    DateTime fechaInicio = dateTimeFromString(getStartDate());

    // Contar dias a cargar
    int diasCargar = DateTime.now().difference(fechaInicio).inDays;

    // Recorrer desde la fecha de inicio hasta hoy, añadir el estado de finalizacion al mapa del HeatMap
    for (int i = 0; i < diasCargar + 1; i++) {
      String fecha = stringFromDateTime(fechaInicio.add(Duration(days: i)));
      // Estado de finalizacion (0 o 1)
      int estadoFinalizacion = db.getEstadoDeFinalizacion(fecha);

      // Año
      int year = fechaInicio.add(Duration(days: i)).year;
      // Mes
      int mes = fechaInicio.add(Duration(days: i)).month;
      // Dia
      int dia = fechaInicio.add(Duration(days: i)).day;

      final porcentajePorDia = <DateTime, int>{
        DateTime(year, mes, dia): estadoFinalizacion
      };

      // Añadir a los datos del mapa
      hetMapDatos.addEntries(porcentajePorDia.entries);
    }
  }
}
