import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_proyfin_dgv/fechas/fecha_hora.dart';

/// Clase que representa el mapa en el que aparecen los días que hemos hecho o no algún ejercicio
class MyHeatMap extends StatelessWidget {

  /// Datos de cada dia (fecha, numero indica ejercicio hecho)
  final Map<DateTime, int>? datos;
  /// Fecha de inicio del mapa
  final String fechaInicio;

  /// Constructor
  const MyHeatMap({super.key, required this.datos, required this.fechaInicio});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding:const EdgeInsets.all(25),
      child: HeatMap(
        startDate: dateTimeFromString(fechaInicio),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datos,
        colorMode: ColorMode.color,
        defaultColor: const Color(0xFFFE5F55),
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const{
          1:Colors.green,
        },
      ),

    );
  }
}
