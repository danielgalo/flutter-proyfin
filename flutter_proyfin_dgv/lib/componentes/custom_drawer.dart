// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_proyfin_dgv/pantallas/pantalla_creditos.dart';
import 'package:flutter_proyfin_dgv/pantallas/pantalla_principal.dart';
import 'package:google_fonts/google_fonts.dart';

/// Drawer personalizado para la aplicación
class CustomDrawer extends StatelessWidget {
  final BuildContext context;

  const CustomDrawer(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF7F7FF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Row(
                children: [
                  Text(
                    'Bienvenido',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF577399),
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: 70, 
                    height: 50, 
                    child: Image.asset(
                      "assets/images/musculo.png",
                      fit: BoxFit.contain, // Ajusta el ajuste de la imagen
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Ejercicio 9
          ListTile(
            title: getItemText("Página principal", const Color(0xFF577399)),
            onTap: () {
              // Cierra el Drawer al hacer clic en un elemento
              Navigator.pop(context);

              // Navega a la PantallaPrincipal
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PantallaPrincipal()),
              );
            },
          ),

          ListTile(
            title: getItemText("Créditos", const Color(0xFF577399)),
            onTap: () {
              // Cierra el Drawer al hacer clic en un elemento
              Navigator.pop(context);

              // Navega a la clase PantallaCreditos
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PantallaCreditos()),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Obtiene el titulo de elemento menu del drawer
Text getItemText(String texto, Color colorElegido) {
  return Text(
    texto,
    style: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: colorElegido),
  );
}
