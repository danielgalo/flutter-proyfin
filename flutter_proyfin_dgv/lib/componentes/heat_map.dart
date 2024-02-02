import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_proyfin_dgv/fechas/fecha_hora.dart';

class MyHeatMap extends StatelessWidget {

  final Map<DateTime, int>? datos;
  final String fechaInicio;

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
        defaultColor: Colors.grey[200],
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
