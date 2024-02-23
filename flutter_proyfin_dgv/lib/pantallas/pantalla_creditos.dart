import 'package:flutter/material.dart';
import 'package:flutter_proyfin_dgv/componentes/custom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

/// Pantalla de créditos de la aplicación accesible desde el drawer navegable
class PantallaCreditos extends StatelessWidget {
  const PantallaCreditos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Créditos',
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(122, 189, 213, 234),
        ),
        backgroundColor: const Color(0xFFBDD5EA),
        drawer: CustomDrawer(context),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              Text(
                "Daniel Galo Vega",
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text(
                  "Estudiante de 2º de FPGS Desarrollo de Aplicaciones Multiplataforma",
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 20, // Espacio entre el texto y la imagen
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  "assets/images/cara-feliz.png",
                  fit: BoxFit.cover, // Ajusta la imagen al contenedor
                ),
              ),
              const SizedBox(
                height: 20, // Espacio entre la imagen y el botón
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      "assets/images/signo-de-github.png",
                      fit: BoxFit.cover, // Ajusta la imagen al contenedor
                    ),
                  ),
                  const SizedBox(
                    width: 20, // Espacio entre la imagen y el botón
                  ),
                  Text("https://github.com/danielgalo/flutter-proyfin",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20, // Espacio entre el texto y la imagen
                  ),
                ],
              )
            ]))));
  }
}
