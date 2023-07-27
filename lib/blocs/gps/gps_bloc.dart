

import 'dart:async';

import 'package:barberia/blocs/gps/gps_state.dart';
import 'package:barberia/blocs/gps/gps_event.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';






class GpsBloc extends Bloc<GpsEvent,GpsState>{

  StreamSubscription? gpsServiceSubscripcion;

  GpsBloc() : super(const GpsState(isGpsEnabled: false,isGpsPermissionGranted:false )){
    on<GpsAndPermissionEvent>((event,emit)=>emit(state.copyWith(
      isGpsEnabled:  event.isGpsEnabled,
      isGpsPermissionGranted: event.isGpsPermissionGranted
    )));

    _init();
  }

  Future<void> _init() async {
   final isEnabled = await _checkGpsStatus();
   final isGranted = await _isPermissionGranted();
   print('isEnabled: $isEnabled, isGranted: $isGranted');

   final gpsInitStatus = await Future.wait([
   _checkGpsStatus(),
   _isPermissionGranted(),
   ]);

   add(GpsAndPermissionEvent(isGpsEnabled: gpsInitStatus[0], isGpsPermissionGranted: gpsInitStatus[1]));
  }

  Future<bool> _isPermissionGranted() async{
    final  isGranted = await Permission.location.isGranted;

    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    gpsServiceSubscripcion = Geolocator.getServiceStatusStream().listen((event) {
      print('service status $event');
      //TODO: disparar eventos...
      final isEnable =(event.index == 1) ? true:false;
      add(GpsAndPermissionEvent(isGpsEnabled: isEnable, isGpsPermissionGranted: state.isGpsPermissionGranted));
      print('service status $isEnable');
    });
    return isEnable;

  }

  Future<void> askGpsAccess() async {
    final status=await Permission.location.request();
   switch (status){
     case PermissionStatus.granted:
       add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
       break;
     case PermissionStatus.denied:
     case PermissionStatus.restricted:
     case PermissionStatus.limited:
     case PermissionStatus.permanentlyDenied:
     add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
     openAppSettings();
   }
  }

  @override
  Future<void> close(){
    //TODO: Limpiar el serviceStatus Stream
    gpsServiceSubscripcion?.cancel();
    return super.close();
  }

}