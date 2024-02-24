/// Entidad ejercicio
class Ejercicio {
  /// Nombre del ejercicio
  String nombre;

  /// Peso del ejercicio
  String peso;

  /// Repeticiones del ejercicio
  String repeticiones;

  /// Series del ejercicio
  String series;

  /// Ejercicio terminado
  bool terminado;

  // Eliminar ejercicio
  bool eliminar; 

  /// Constructor
  Ejercicio({
    required this.nombre,
    required this.peso,
    required this.repeticiones,
    required this.series,
    this.terminado = false,
    this.eliminar = false, // Por defecto, no se eliminará el ejercicio
  });
}
