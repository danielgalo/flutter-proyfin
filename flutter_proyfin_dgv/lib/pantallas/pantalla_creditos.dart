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
                  "Estudiante de FPGS Desarrollo de Aplicaciones Multiplataforma",
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  "assets/images/cara-feliz.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              getContactChip(
                  "github.com/danielgalo", "assets/images/signo-de-github.png"),
              const SizedBox(
                height: 20,
              ),
              getContactChip("linkedin.com/in/daniel-galo-vega-362350258/",
                  "assets/images/logotipo-de-linkedin.png"),
              const SizedBox(
                height: 20,
              ),
              getContactChip("dgalovega@gmail.com",
                  "assets/images/gmail.png"),
            ]))));
  }

  /// Obtiene un chip con una imagen de una red social / plataforma y su link
  Row getContactChip(String link, String imagePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20.0), // Agrega margen a la izquierda
          child: SizedBox(
            width: 40,
            height: 40,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover, // Ajusta la imagen al contenedor
            ),
          ),
        ),
        const SizedBox(
          width: 20, // Espacio entre la imagen y el texto
        ),
        Text(link,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center),
        const SizedBox(
          height: 20, // Espacio entre el texto y la imagen
        ),
      ],
    );
  }
}
