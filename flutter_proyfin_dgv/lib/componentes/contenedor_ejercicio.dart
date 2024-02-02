// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';


/// Clase que representa una Tile con la información de un ejercicio
class EjercicioTile extends StatelessWidget {
  final String nombreEjercicio;
  final String peso;
  final String repeticiones;
  final String series;
  final bool terminado;

  void Function(bool?)? onTerminadoChanged;

   EjercicioTile(
      {super.key,
      required this.nombreEjercicio,
      required this.peso,
      required this.repeticiones,
      required this.series,
      required this.terminado,
      required this.onTerminadoChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // El titulo es el nombre del ejercicio obtenido por el nombre del entrenamiento
      title: Text(nombreEjercicio),

      // Como contenido adicional, se muestran los demás atributos del entrenamiento
      subtitle: Row(
        children: [
          Chip(label: Text("${peso}KG")),
          Chip(label: Text("$repeticiones repeticiones")),
          Chip(label: Text("$series series")),
        ],
      ),
      trailing: Checkbox(value: terminado, onChanged: (value) => onTerminadoChanged!(value) ,),
    );
  }
}
