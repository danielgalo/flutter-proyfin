import 'package:flutter/material.dart';
import 'package:flutter_proyfin_dgv/componentes/heat_map.dart';
import 'package:flutter_proyfin_dgv/pantallas/pantalla_entrenamiento.dart';
import 'package:flutter_proyfin_dgv/persistencia/datos_entrenamiento.dart';
import 'package:google_fonts/google_fonts.dart';
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
              title: Text(
                "Crear un entrenamiento",
                style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xFFF7F7FF),
              content: TextField(
                autocorrect: false,
                controller: nuevoNombreEntrenamientoController,
                decoration: const InputDecoration(
                    labelText: 'Entrenamiento',
                    labelStyle: TextStyle(
                      color: Color(0xFF577399),
                    ),
                    helperText: "Pecho, cardio, piernas...",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF577399))),
                    hintText: "Nombre del entrenamiento...",
                    prefixIcon: Icon(
                      Icons.sports_gymnastics,
                      color: Color(0xFF577399),
                    )),
              ),
              actions: [
                MaterialButton(
                  onPressed: guardarEntrenamiento,
                  child: Text(
                    "Guardar",
                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                  ),
                ),
                MaterialButton(
                  onPressed: cancelarEntrenamiento,
                  child: Text(
                    "Cancelar",
                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ));
  }

  /// Guarda un entrenamiento
  guardarEntrenamiento() {
    // Si el nombre del entrenamiento está vacío mostrar mensaje de error
    if (nuevoNombreEntrenamientoController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error',
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold, fontSize: 20)),
          content: Text('Se debe de proporcionar un nombre de entrenamiento.',
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
  }

  eliminarEntrenamiento(String entrenamiento) {
    Provider.of<DatosEntrenamiento>(context, listen: false)
        .eliminaEntrenamiento(entrenamiento);
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
          backgroundColor: const Color(0xFF577399),
          appBar: AppBar(
            title: Text(
              "Gestión de Entrenamientos",
              style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(125, 0, 0, 0),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFFFE5F55),
            onPressed: creaEntrenamiento,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),

          // BODY
          body: ListView(
            children: [
              // Mapa de entrenamientos y logo
              Row(
                children: [
                  MyHeatMap(
                      datos: value.hetMapDatos,
                      fechaInicio: value.getStartDate()),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        "assets/images/weightlifting.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              // Contenedor, como hijo tendrá tantos entrenamientos como haya en la BD
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
       
                ),
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getListaEntrenamientos().length,
                  itemBuilder: (context, index) => Card(
                    color: const Color(0xFFBDD5EA),
                    // Envuelve cada ListTile en un Card para estilizarlo mejor
                    elevation:
                        3, // Ajusta la elevación del Card según tus preferencias
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(
                        value.getListaEntrenamientos()[index].nombre,
                        style:
                            GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                      ),
                      // ICONOS
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ICONO ELIMINAR ENTRENAMIENTO
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Confirmar eliminación',
                                      style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '¿Estás seguro de que deseas eliminar este entrenamiento?',
                                          style: GoogleFonts.quicksand(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        // Espacio
                                        const SizedBox(height: 10.0),
                                        Text(
                                          'Asegurate de no eliminar el entrenamiento el mismo día en el que lo has realizado.\n',
                                          style: GoogleFonts.quicksand(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '¡Si no perderás tu progreso!',
                                          style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Cierra el diálogo
                                        },
                                        child: Text('Cancelar',
                                            style: GoogleFonts.quicksand(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    const Color(0xFF577399))),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Cierra el diálogo
                                          eliminarEntrenamiento(value
                                              .getListaEntrenamientos()[index]
                                              .nombre); // Llama a la función para eliminar el entrenamiento
                                        },
                                        child: Text(
                                          'Eliminar',
                                          style: GoogleFonts.quicksand(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),

                          // IR A ENTRENAMIENTO
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                            onPressed: () => navegarPantallaEntrenamiento(
                              value.getListaEntrenamientos()[index].nombre,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
