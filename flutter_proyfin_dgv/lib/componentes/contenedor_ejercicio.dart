// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_proyfin_dgv/componentes/chip_info_ejercicio.dart';
import 'package:google_fonts/google_fonts.dart';

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
      title: Row(
        children: [
          Expanded(
            child: Text(
              nombreEjercicio,
              style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
              overflow: TextOverflow
                  .ellipsis, // Trunca el texto si es demasiado largo
            ),
          ),
        ],
      ),

      // Como contenido adicional, se muestran los demás atributos del entrenamiento
      subtitle: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ChipWithMargin(
              child: Chip(
                label: Text(
                  "${peso}KG",
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ChipWithMargin(
              child: Chip(
                label: Text(
                  "$repeticiones Repeticiones",
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ChipWithMargin(
              child: Chip(
                label: Text(
                  "$series Series",
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      trailing: Checkbox(
        value: terminado,
        onChanged: (value) => onTerminadoChanged!(value),
      ),
    );
  }
}
