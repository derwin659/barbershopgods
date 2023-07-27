import 'package:barberia/screens/gps_access_screen.dart';
import 'package:barberia/screens/home_screen.dart';
import 'package:barberia/screens/politicas_privacidad.dart';
import 'package:barberia/screens/signin_screen.dart';
import 'package:barberia/screens/terminos_condiciones.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/gps/gps_bloc.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({Key? key}) : super(key: key);

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  @override
  Widget build(BuildContext context) {
    bool? _isTermAndCondiciones = false;
    bool? _isPoliticAndPrivacity = false;
    bool? _isNotificationMaterials = false;

    final List<PageViewModel> pages = [
      PageViewModel(
          title: 'Bienvenidos a BarberShop GODS',
          body:
              'Este aplicativo te ayudará a realizar reservas desde la comodidad de tu hogar, garantizando que no pierdas tiempo cuando realicen tu corte de cabello o servicio elegido.',
          image: Center(
            child: Image.asset('assets/images/logog.png'),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
            bodyTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.blue),
          )),
      PageViewModel(
          title: 'Elige tu ciudad',
          body:
              'Para reservar lo primero que debes hacer es elegir la ciudad donde te realizarás el servicio deseado.',
          image: Center(
            child: Image.asset('assets/images/city.jpg'),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
            bodyTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.blue),
          )),
      PageViewModel(
          title: 'Elige BarberShop',
          body:
              'Luego de haber elegido tu ciudad, lo segundo es elegir el local barbershop GODS, más cercano.',
          image: Center(
            child: Image.asset('assets/images/barber.jpg'),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
            bodyTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.blue),
          )),
      PageViewModel(
          title: 'Elige Barbero favorito',
          body:
              'Luego de elegir el local, es hora de elegir tu barbero favorito.',
          image: Center(
            child: Image.asset('assets/images/barberelect.jpg'),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
            bodyTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.blue),
          )),
      PageViewModel(
          title: 'Selecciona Fecha',
          body:
              'Luego de elegir el barbero, ahora debes seleccionar el día y la hora para realizar tu servicio.',
          image: Center(
            child: Image.asset('assets/images/calendario1.jpg'),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
            bodyTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.blue),
          )),
      PageViewModel(
          title: '¿Como llegar?',
          body:
              'Tendrás un botón que te llevara hasta  barbershop GODS a través del aplicativo, especialmente si andas en motocicleta o auto.',
          footer: ElevatedButton(
            onPressed: () {
              _displayPermission(context, _isPoliticAndPrivacity,
                  _isNotificationMaterials, _isTermAndCondiciones);
            },
            child: const Text("Reservemos"),
          ),
          image: Center(
            child: Image.asset('assets/images/destino.jpg'),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
            bodyTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.blue),
          )),
    ];

    return Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xFF0E6BAC)),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IntroductionScreen(
            pages: pages,
            globalBackgroundColor: Colors.white,
            dotsDecorator: const DotsDecorator(
                size: Size(0, 25),
                color: Colors.blue,
                activeSize: Size.square(20),
                activeColor: Colors.red),
            showDoneButton: true,
            done: const Text(
              'Salir',
              style: TextStyle(fontSize: 18),
            ),
            showSkipButton: true,
            skip: const Text(
              'Escapar',
              style: TextStyle(fontSize: 18),
            ),
            showNextButton: true,
            next: const Icon(
              Icons.arrow_forward,
              size: 25,
            ),
            onDone: () {
              _displayPermission(context, _isPoliticAndPrivacity,
                  _isNotificationMaterials, _isTermAndCondiciones);
            },
            curve: Curves.bounceOut,
          )
        ));
  }

  static void OnDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  var _selected = "";
  var _selected1 = "";

  _displayDialog(BuildContext context, bool _isTermAndCondiciones,
      bool _isPoliticAndPrivacity, bool _isNotificationMaterials) async {
    _selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return SimpleDialog(
            alignment: Alignment.center,

            backgroundColor: Colors.black87,
            titleTextStyle: TextStyle(),
            title: Text('Terminos y Condiciones',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            children: [
              SimpleDialogOption(
                   child: Row(
                      children: [
                        Checkbox(
                          onChanged: (bool? value) {
                            print(value);
                            setState(() {
                              _isTermAndCondiciones = value!;
                            });
                          },
                          value: _isTermAndCondiciones,
                        ),
                        Text("Acepto los",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                       Flexible(child:  TextButton(
                           onPressed: () {
                             Navigator.pushReplacement(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) =>
                                     const TermAnNotifications()));
                           },
                           child: Text("terminos y condiciones",
                               style: TextStyle(
                                   fontSize: 12,
                                   fontWeight: FontWeight.normal,
                                   color: Colors.cyanAccent)))),
                      ],
                    )),

              SimpleDialogOption(
                  child: Row(
                    children: [
                      Checkbox(
                        onChanged: (bool? value) {
                          print(value);
                          setState(() {
                            _isPoliticAndPrivacity = value!;
                          });
                        },
                        value: _isPoliticAndPrivacity,
                      ),
                      Text("Acepto las",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.white)),

                      Flexible(child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const PoliticalPrivacity()));
                          },
                          child: Text("politicas y privacidad",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.cyanAccent))))
                    ],
                  )),
              SimpleDialogOption(
                child: Row(
                  children: [
                    Checkbox(
                      onChanged: (bool? value) {
                        print(value);
                        setState(() {
                          _isNotificationMaterials = value!;
                        });
                      },
                      value: _isNotificationMaterials,
                    ),
                  Flexible(child: Text("Acepto el envio de publicidad",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.white))),
                  ],
                ),
              ),
              validateStatus(_isPoliticAndPrivacity, _isNotificationMaterials,
                  _isTermAndCondiciones)
            ],
            elevation: 30,
            //backgroundColor: Colors.green,
          );
        });
      },
    );
  }

  validateStatus(bool isPoliticAndPrivacity, bool isNotificationMaterials,
      bool isTermAndCondiciones) {
    print("derwin");
    print(isPoliticAndPrivacity);
    if (isPoliticAndPrivacity == true &&
        isNotificationMaterials == true &&
        isTermAndCondiciones == true) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          // side: BorderSide(color: Colors.yellow, width: 5),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 15, fontStyle: FontStyle.normal),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        onPressed: () {
          OnDone(context);
        },
        child: const Text("Comencemos"),
      );
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white12,
        // side: BorderSide(color: Colors.yellow, width: 5),
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 15, fontStyle: FontStyle.normal),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
      onPressed: () {},
      child: const Text("Comencemos"),
    );
  }

  void _displayPermission(BuildContext context, bool isPoliticAndPrivacity,
      bool isNotificationMaterials, bool isTermAndCondiciones) async {
    _selected1 = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return SimpleDialog(
            alignment: Alignment.center,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(),
            title: Container(
                width: MediaQuery.of(context).size.width,
                child: Text('Notificacion de Permiso',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
            children: [
              SimpleDialogOption(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Text(
                        'BarberShop GODS,  recoge datos de ubicación para habilitar el seguimiento hacia la barberia, aunque la aplicacion este cerrada o no se este usando.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
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
                          _displayDialog(context, isTermAndCondiciones,
                              isPoliticAndPrivacity, isNotificationMaterials);
                        }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                          _displayDialog(context, isTermAndCondiciones,
                              isPoliticAndPrivacity, isNotificationMaterials);
                        }),
                  )
                ],
              )),
            ],
            elevation: 30,
            //backgroundColor: Colors.green,
          );
        });
      },
    );
  }
}
