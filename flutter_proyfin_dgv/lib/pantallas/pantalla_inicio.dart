import 'package:flutter/material.dart';
import 'package:flutter_proyfin_dgv/componentes/custom_drawer.dart';
import 'package:flutter_proyfin_dgv/pantallas/pantalla_principal.dart';
import 'package:google_fonts/google_fonts.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio',
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
                "Gym Streak",
                style: GoogleFonts.bowlbyOneSc(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20, // Espacio entre el texto y la imagen
              ),
              SizedBox(
                width: 200, 
                height: 200, 
                child: Image.asset(
                  "assets/images/prensa-de-banco.png",
                  fit: BoxFit.cover, // Ajusta la imagen al contenedor
                ),
              ),
              const SizedBox(
                height: 20, // Espacio entre la imagen y el botón
              ),

              // Contenedor que hace la funcion de un boton
              GestureDetector(
                onTap: () {
                  // Aquí puedes realizar la navegación a otra pantalla
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(25),
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(169, 48, 48, 48),
                        offset: Offset(5, 5),
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Comenzar',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
