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
            buildTextField(ejercicioController, "Ejercicio",
                "Press banca, remo...", TextInputType.name),

            // Espacio
            const SizedBox(height: 5.0),

            buildTextField(
                pesoController, "Peso", "Peso en KG", TextInputType.number),

            // Espacio
            const SizedBox(height: 5.0),

            buildTextField(repeticionesController, "Repeticiones",
                "Número de repeticiones", TextInputType.number),

            // Espacio
            const SizedBox(height: 5.0),

            buildTextField(seriesController, "Series", "Número de series",
                TextInputType.number),
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
  TextField buildTextField(TextEditingController txtController, String title,
      String hintText, TextInputType inputType) {
    return TextField(
      controller: txtController,
      keyboardType: inputType,
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
    if (ejercicioController.text.isEmpty ||
        pesoController.text.isEmpty ||
        repeticionesController.text.isEmpty ||
        seriesController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error',
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold, fontSize: 20)),
          content: Text('Por favor, completa todos los campos.',
              style: GoogleFonts.quicksand(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ],
        ),
      );
    } else {
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
        backgroundColor: const Color(0xFFFE5F55),
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
  bool _eliminar = false; // Estado para controlar la eliminación

  return Dismissible(
    key: UniqueKey(),
    direction: DismissDirection.endToStart, // Se arrastra hacia la izquierda para mostrar el botón
    background: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(Icons.delete, color: Colors.white),
    ),
    onDismissed: (direction) {
      if (_eliminar) {
        // Ejecutar la acción de eliminación solo si el usuario confirmó
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Eliminar', style: GoogleFonts.quicksand(),),
              content: Text('¿Estás seguro de que quieres eliminar este ejercicio?', style: GoogleFonts.quicksand()),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Cancelar la eliminación
                    Navigator.of(context).pop();
                    setState(() {
                      _eliminar = false;
                    });
                  },
                  child: Text('Cancelar', style: GoogleFonts.quicksand()),
                ),
                TextButton(
                  onPressed: () {
                    // Confirmar la eliminación
                    Navigator.of(context).pop();
                    // Aquí puedes ejecutar la acción de eliminar el ejercicio
                    Provider.of<DatosEntrenamiento>(context, listen: false).eliminaEjercicio(ejercicio.nombre, widget.nombreEntrenamiento);

                  },
                  child: Text('Eliminar', style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      } else {
        // Si el usuario cancela, no se elimina el elemento
        setState(() {
          _eliminar = false;
        });
      }
    },
    confirmDismiss: (direction) async {
      // Mostrar el cuadro de diálogo de confirmación solo si el usuario desliza hacia la izquierda
      if (direction == DismissDirection.endToStart) {
        final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Eliminar', style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
              content: const Text('¿Estás seguro de que quieres eliminar este ejercicio? Se borrará su progreso'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Cancelar la eliminación
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Cancelar', style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () {
                    // Confirmar la eliminación
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Eliminar', style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
        return result ?? false; // Si el usuario cierra el cuadro de diálogo sin seleccionar una opción, se cancela la eliminación
      } else {
        return false; // No confirmar la eliminación para otros gestos
      }
    },
    child: Container(
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
    ),
  );
}


}
