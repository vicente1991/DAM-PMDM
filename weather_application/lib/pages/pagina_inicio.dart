import 'package:flutter/material.dart';
import 'package:weather_application/pages/mapa_inicio.dart';

class PaginaInicio extends StatefulWidget {
  const PaginaInicio({Key? key}) : super(key: key);

  @override
  _PaginaInicioState createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/earth.jpg",
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Container(
                      color: Colors.white,
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: Text('Seleccionar Ciudad'),
                      ),
                    ),
                  ),
                ),
              ),
              const MapClickPageInicio()
            ],
          ),
        ),
      ),
    );
  }
}
