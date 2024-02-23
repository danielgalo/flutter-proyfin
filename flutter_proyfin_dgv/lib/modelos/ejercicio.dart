class Ejercicio {
  String nombre;
  String peso;
  String repeticiones;
  String series;
  bool terminado;
  bool eliminar; // Nuevo atributo para controlar si se debe eliminar el ejercicio

  Ejercicio({
    required this.nombre,
    required this.peso,
    required this.repeticiones,
    required this.series,
    this.terminado = false,
    this.eliminar = false, // Por defecto, no se eliminará el ejercicio
  });
}