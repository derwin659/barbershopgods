
import 'package:barberia/blocs/blocs.dart';
import 'package:barberia/screens/home_screen.dart';
import 'package:barberia/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return !state.isGpsEnabled
              ? const _EnableGpsMessage()
              : const _AccesButton();
        },
      )
        //_AccesButton(),
      ),
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SimpleDialog(
        alignment: Alignment.center,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(),
        title: Text(
            'Para mejorar la experiencia ,activa la ubicacion del dispositivo, que usa los servicios de ubicacion de Google.',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue)),
        children: [
          Container(
              margin: EdgeInsets.all(15),
              alignment: Alignment.center,
              color: Colors.white,
              child: Column(children: [

                Container(
                  margin: EdgeInsets.all(12),
                  child: MaterialButton(
                      child: const Text(
                        'No, Gracias',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                      shape: const StadiumBorder(),
                      elevation: 0,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        //TODO : Por hacer
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen1()));
                      }),
                )

              ]))
        ]);
  }
}

class _AccesButton extends StatefulWidget {
  const _AccesButton({Key? key}) : super(key: key);

  @override
  State<_AccesButton> createState() => _AccesButtonState();
}

class _AccesButtonState extends State<_AccesButton> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(),
      title: Text('Notificacion de Permiso',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
      children: [
        Container(
          margin: EdgeInsets.all(15),
          alignment: Alignment.center,
          color: Colors.white,
          child: Text(
              'BarberShop GODS,  recoge datos de ubicación para habilitar el seguimiento hacia la barberia, aunque la aplicacion este cerrada o no se este usando',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
        ),
        Container(
          margin: EdgeInsets.all(12),
          child: MaterialButton(
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              shape: const StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                //TODO : Por hacer
                final gpsBloc = BlocProvider.of<GpsBloc>(context);
                gpsBloc.askGpsAccess();
              }),
        ),
        Container(
          margin: EdgeInsets.all(12),
          child: MaterialButton(
              child: const Text(
                'Ahora no',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: const StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                //TODO : Por hacer
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen1()));
              }),
        )
        //  validateStatus(_isPoliticAndPrivacity, _isNotificationMaterials,
        //      _isTermAndCondiciones)
      ],
      elevation: 15,
      //backgroundColor: Colors.green,
    );
  }
}
