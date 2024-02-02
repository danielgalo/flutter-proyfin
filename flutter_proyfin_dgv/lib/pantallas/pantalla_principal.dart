import 'package:flutter/material.dart';
import 'package:flutter_proyfin_dgv/componentes/heat_map.dart';
import 'package:flutter_proyfin_dgv/pantallas/pantalla_entrenamiento.dart';
import 'package:flutter_proyfin_dgv/persistencia/datos_entrenamiento.dart';
import 'package:provider/provider.dart';

/// Clase que representa la pantalla principal
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

/// State de la pantalla principal
class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  void initState() {
    super.initState();
    Provider.of<DatosEntrenamiento>(context, listen: false)
        .iniciaListaEntrenamientos();
  }

  final nuevoNombreEntrenamientoController = TextEditingController();

  /// Crea un entrenamiento
  creaEntrenamiento() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Crear un entrenamiento"),
              content: TextField(
                controller: nuevoNombreEntrenamientoController,
              ),
              actions: [
                MaterialButton(
                  onPressed: guardarEntrenamiento,
                  child: const Text("Guardar"),
                ),
                MaterialButton(
                  onPressed: cancelarEntrenamiento,
                  child: const Text("Cancelar"),
                ),
              ],
            ));
  }

  /// Guarda un entrenamiento
  guardarEntrenamiento() {
    // Input del usuario, a través del controlador
    String entrenamientoInput = nuevoNombreEntrenamientoController.text;
    // Obtener los datos de entrenamiento, asignarle a su método de añadir entrenamiento el texto introducido por el usuario
    Provider.of<DatosEntrenamiento>(context, listen: false)
        .addEntrenamiento(entrenamientoInput);
    // Cerrar el diálogo de añadir entrenamiento
    Navigator.pop(context);
    // Borra el texto del controlador
    clearController();
  }

  /// Cancela la acción de guardar un entrenamiento
  cancelarEntrenamiento() {
    // Cerrar el diálogo de añadir entrenamiento
    Navigator.pop(context);
    // Borra el texto del controlador
    clearController();
  }

  /// Limpia el controlador
  void clearController() {
    nuevoNombreEntrenamientoController.clear();
  }

  /// Navega a la pantalla de un entrenamiento
  navegarPantallaEntrenamiento(String nombreEntrenamiento) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PantallaEntrenamiento(
                nombreEntrenamiento: nombreEntrenamiento)));
  }

  @override
  Widget build(BuildContext context) {
    // Devolver consumer para poder manejar los Datos del entrenamiento
    return Consumer<DatosEntrenamiento>(
      // value representa un objeto DatosEntrenamiento, el child será el Scaffold
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[500],
          appBar: AppBar(
            title: const Text("Gestión de Entrenamientos"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: creaEntrenamiento,
            child: Icon(Icons.add),
          ),

          // Lista con los entrenamientos
          body: ListView(
            children: [
              // Mapa
              MyHeatMap(datos: value.hetMapDatos, fechaInicio: value.getStartDate()),

              // Lista de entrenamientos
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                  // La longitud de la lista es la cantidad de entrenamientos que haya guardado
                  itemCount: value.getListaEntrenamientos().length,
                  // Mostrar entrenamientos
                  itemBuilder: (context, index) => ListTile(
                        title:
                            Text(value.getListaEntrenamientos()[index].nombre),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () => navegarPantallaEntrenamiento(
                              value.getListaEntrenamientos()[index].nombre),
                        ),
                      )),
            ],
          )),
    );
  }
}
