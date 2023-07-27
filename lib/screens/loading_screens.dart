

import 'package:barberia/screens/gps_access_screen.dart';
import 'package:barberia/screens/ubicaciones.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';

import '../blocs/gps/gps_bloc.dart';
import '../blocs/gps/gps_state.dart';
class LoadingScreens extends StatelessWidget {
  const LoadingScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocBuilder<GpsBloc,GpsState>(
        builder: (context,state){
          return state.isAllGranted ? const Ubicaciones(): const GpsAccessScreen();
        },
      )
    );
  }
}
