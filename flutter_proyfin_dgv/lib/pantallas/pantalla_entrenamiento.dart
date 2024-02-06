import 'package:flutter/material.dart';
import 'package:flutter_proyfin_dgv/componentes/contenedor_ejercicio.dart';
import 'package:flutter_proyfin_dgv/modelos/ejercicio.dart';
import 'package:flutter_proyfin_dgv/persistencia/datos_entrenamiento.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

/// Pantalla de un entrenamiento, la cual contiene tantos ejercicios como el usuario introduzca o haya en la base de datos
class PantallaEntrenamiento extends StatefulWidget {
  final String nombreEntrenamiento;
  const PantallaEntrenamiento({Key? key, required this.nombreEntrenamiento})
      : super(key: key);

  @override
  State<PantallaEntrenamiento> createState() => _PantallaEntrenamientoState();
}

/// State de la clase
class _PantallaEntrenamientoState extends State<PantallaEntrenamiento> {
  final ejercicioController = TextEditingController();
  final pesoController = TextEditingController();
  final repeticionesController = TextEditingController();
  final seriesController = TextEditingController();

  @override
  void dispose() {
    ejercicioController.dispose();
    pesoController.dispose();
    repeticionesController.dispose();
    seriesController.dispose();
    super.dispose();
  }

  /// Vigila la checkbox de cada ejercicio, para actualizar valores al ser marcada o desmarcada
  void checkBoxChanged(String nombreEntrenamiento, String nombreEjercicio) {
    Provider.of<DatosEntrenamiento>(context, listen: false)
        .terminaEjercicio(nombreEntrenamiento, nombreEjercicio);
  }

  /// Diálogo emergente al pulsar el botón de añadir ejercicio,
  void nuevoEjercicio() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF7F7FF),
        title: Text(
          "Añade un ejercicio",
          style:
              GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTextField(
              ejercicioController,
              "Ejercicio",
              "Press banca, remo...",
            ),

            // Espacio
            const SizedBox(height: 5.0),

            buildTextField(
              pesoController,
              "Peso",
              "Peso en KG",
            ),

            // Espacio
            const SizedBox(height: 5.0),

            buildTextField(
              repeticionesController,
              "Repeticiones",
              "Número de repeticiones",
            ),

            // Espacio
            const SizedBox(height: 5.0),

            buildTextField(
              seriesController,
              "Series",
              "Número de series",
            ),
          ],
        ),
        actions: [
          MaterialButton(
              onPressed: guardarEjercicio,
              child: Text(
                "Guardar",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, fontSize: 20),
              )),
          MaterialButton(
              onPressed: cancelarEjercicio,
              child: Text(
                "Cancelar",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, fontSize: 20),
              )),
        ],
      ),
    );
  }

  /// Obtiene un textfield
  TextField buildTextField(
      TextEditingController txtController, String title, String hintText) {
    return TextField(
      controller: txtController,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(
          color: Color(0xFF577399),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF577399))),
        hintText: hintText,
      ),
    );
  }

  /// Guarda un ejercicio creado por el usuario
  void guardarEjercicio() {
    Provider.of<DatosEntrenamiento>(context, listen: false).addEjercicio(
      widget.nombreEntrenamiento,
      ejercicioController.text,
      pesoController.text,
      repeticionesController.text,
      seriesController.text,
    );
    Navigator.pop(context);
    clearControllers();
  }

  /// Cancela la creación de un ejercicio, cierra el diálogo
  void cancelarEjercicio() {
    Navigator.pop(context);
    clearControllers();
  }

  /// Vacía el texto de los controladores
  void clearControllers() {
    ejercicioController.clear();
    pesoController.clear();
    repeticionesController.clear();
    seriesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDD5EA),
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const  Color(0xFFFE5F55),
        onPressed: nuevoEjercicio,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _buildExerciseList(),
    );
  }

  /// Construye app bar
  PreferredSizeWidget? _buildAppBar() {
    return AppBar(
      title: Text(widget.nombreEntrenamiento),
      backgroundColor: const Color(0xFF577399),
    );
  }

  /// Construye lista de ejercicios
  Widget _buildExerciseList() {
    return Consumer<DatosEntrenamiento>(
      builder: (context, value, child) => ListView.builder(
        itemCount:
            value.getEjerciciosDeEntrenamiento(widget.nombreEntrenamiento),
        itemBuilder: (context, index) => _buildExerciseTile(value
            .getEntrenamientoByNombre(widget.nombreEntrenamiento)
            .ejercicios[index]),
      ),
    );
  }

  /// Crea un tile de ejercicio, con toda su información
  Widget _buildExerciseTile(Ejercicio ejercicio) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: EjercicioTile(
        nombreEjercicio: ejercicio.nombre,
        peso: ejercicio.peso,
        repeticiones: ejercicio.repeticiones,
        series: ejercicio.series,
        terminado: ejercicio.terminado,
        onTerminadoChanged: (val) =>
            checkBoxChanged(widget.nombreEntrenamiento, ejercicio.nombre),
      ),
    );
  }
}
