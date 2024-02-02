import 'package:flutter/material.dart';
import 'package:flutter_proyfin_dgv/componentes/contenedor_ejercicio.dart';
import 'package:flutter_proyfin_dgv/persistencia/datos_entrenamiento.dart';
import 'package:provider/provider.dart';

class PantallaEntrenamiento extends StatefulWidget {
  final String nombreEntrenamiento;
  const PantallaEntrenamiento({super.key, required this.nombreEntrenamiento});

  @override
  State<PantallaEntrenamiento> createState() => _PantallaEntrenamientoState();
}

class _PantallaEntrenamientoState extends State<PantallaEntrenamiento> {
  /// Ejercicio terminado es presionado
  void checkBoxChanged(String nombreEntrenamiento, String nombreEjercicio) {
    // Desde el proveedor, acceder al método de terminar ejercicio
    Provider.of<DatosEntrenamiento>(context, listen: false)
        .terminaEjercicio(nombreEntrenamiento, nombreEjercicio);
  }

  // Controladores de texto para los campos del ejercicio
  final ejercicioController = TextEditingController();
  final pesoController = TextEditingController();
  final repeticionesController = TextEditingController();
  final seriesController = TextEditingController();

  /// Crea un nuevo ejercicio
  nuevoEjercicio() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Añade un ejercicio"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nombre del ejercicio
                  TextField(
                    controller: ejercicioController,
                  ),
                  // Peso
                  TextField(
                    controller: pesoController,
                  ),
                  // Repeticiones
                  TextField(
                    controller: repeticionesController,
                  ),
                  // Series
                  TextField(
                    controller: seriesController,
                  ),
                ],
              ),
              actions: [
              MaterialButton(
                  onPressed: guardarEjercicio,
                  child: Text("Guardar"),
                ),
                MaterialButton(
                  onPressed: cancelarEjercicio,
                  child: Text("Cancelar"),
                ),
              ],
            ));
  }

  /// Guarda un entrenamiento
  guardarEjercicio() {
    // Input del usuario, a través de los controladores
    String entrenamientoInput = ejercicioController.text;
    String pesoInput = pesoController.text;
    String repeticionesInput = repeticionesController.text;
    String seriesInput = seriesController.text;

    // Añadir ejercicio a entrenamiento con los campos recibidos del usuario
    Provider.of<DatosEntrenamiento>(context, listen: false).addEjercicio(
        widget.nombreEntrenamiento,
        entrenamientoInput,
        pesoInput,
        repeticionesInput,
        seriesInput);

    Navigator.pop(context);
    // Borra el texto del controlador
    clearControllers();
  }

  /// Cancela la acción de guardar un entrenamiento
  cancelarEjercicio() {
    // Cerrar el diálogo de añadir entrenamiento
    Navigator.pop(context);
    // Borra el texto del controlador
    clearControllers();
  }

  /// Limpia todos los controladores
  void clearControllers() {
    ejercicioController.clear();
    pesoController.clear();
    repeticionesController.clear();
    seriesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatosEntrenamiento>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                title: Text(widget.nombreEntrenamiento),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: nuevoEjercicio,
              ),
              body: ListView.builder(
                  // Lista de ejercicios, habrá tantos como se hayan añadido a la lista
                  itemCount: value
                      .getEjerciciosDeEntrenamiento(widget.nombreEntrenamiento),
                  itemBuilder: (context, index) => EjercicioTile(
                      nombreEjercicio: value
                          .getEntrenamientoByNombre(widget.nombreEntrenamiento)
                          .ejercicios[index]
                          .nombre,
                      peso: value
                          .getEntrenamientoByNombre(widget.nombreEntrenamiento)
                          .ejercicios[index]
                          .peso,
                      repeticiones: value
                          .getEntrenamientoByNombre(widget.nombreEntrenamiento)
                          .ejercicios[index]
                          .repeticiones,
                      series: value
                          .getEntrenamientoByNombre(widget.nombreEntrenamiento)
                          .ejercicios[index]
                          .series,
                      terminado: value
                          .getEntrenamientoByNombre(widget.nombreEntrenamiento)
                          .ejercicios[index]
                          .terminado,
                      onTerminadoChanged: (val) => checkBoxChanged(
                          widget.nombreEntrenamiento,
                          value
                              .getEntrenamientoByNombre(
                                  widget.nombreEntrenamiento)
                              .ejercicios[index]
                              .nombre))),
            ));
  }
}
