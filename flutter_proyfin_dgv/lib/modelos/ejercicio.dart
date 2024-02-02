class Ejercicio{
  final String nombre;
  final String peso;
  final String repeticiones;
  final String series;
  bool terminado;

  Ejercicio({required this.nombre, required this.peso, required this.repeticiones, required this.series, this.terminado=false});
}