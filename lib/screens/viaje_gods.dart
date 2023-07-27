import 'dart:async';
import 'dart:math';
import 'package:barberia/screens/user_history_screen.dart';
import 'package:barberia/screens/videos_barberia.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'booking_screen.dart';
import 'home_screen.dart';

class ViajeGods extends StatefulWidget {
  const ViajeGods({Key? key}) : super(key: key);

  @override
  State<ViajeGods> createState() => _ViajeGodsState();
}


double latitud = 0;
double longitud = 0;
final LatLng toPoint = const LatLng(-13.5231923, -71.9618708);
Map<MarkerId, Marker> markers = {};



class _ViajeGodsState extends State<ViajeGods> {


  late GoogleMapController _mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  Completer<GoogleMapController> _controller = Completer();
  Future<void> getPosition() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var lastPosition = await Geolocator.getLastKnownPosition();
    position.longitude;

    if(mounted){
      setState(() {
        longitud = position.longitude;
        latitud = position.latitude;
      });
    };




  }
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(latitud, longitud),
    zoom: 9.4746,
  );
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    BitmapDescriptor myIcon;

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/my_icon.png')
        .then((onValue) {
      myIcon = onValue;
    });

    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position,infoWindow: InfoWindow(title: "derwin",snippet: "gods"));
    markers[markerId] = marker;

  }



  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
    _centerView();
  }
  _centerView() async{
    await  _mapController.getVisibleRegion();
    var left = min(latitud,toPoint.latitude);
    var right = max(latitud,toPoint.latitude);
    var top = max(longitud,toPoint.longitude);
    var botooms = min(longitud,toPoint.longitude);
    var bounds = LatLngBounds(southwest: LatLng(left,botooms), northeast: LatLng(right,top));
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController.animateCamera(cameraUpdate);
  }
  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCUIg4mLtwsnZCm8WnhIJ37rmOXNQBpl1M",
        PointLatLng(latitud, longitud),
        PointLatLng(toPoint.latitude, toPoint.longitude)
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;

    if(mounted){
      setState(() {});
    }

  }




  @override
  Widget build(BuildContext context) {


    getPosition();
    print(latitud);
    print(longitud);
    _addMarker(
      LatLng(latitud, longitud),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(toPoint.latitude, toPoint.longitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(150),
    );

    _getPolyline();


  return Container(

  child:  Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: Container(
        alignment: Alignment.center,
        child: Text("Camino hasta la barberia"),),
      automaticallyImplyLeading: false,
    ),
    floatingActionButton: Container(

        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          child: Icon(Icons.zoom_out_map),
          onPressed: _centerView,
        )
    ),
    bottomNavigationBar: Container(
      color: Colors.blue,
       child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.close,size: 38,color: Colors.red,),
          onPressed: () {
            @override
            void dispose() {

              super.dispose();
            }
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen1()));
          },

        )
    ),
    body: Container(
      child: GoogleMap(
          buildingsEnabled: true,
          mapType: MapType.normal,
          mapToolbarEnabled:true,
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          myLocationButtonEnabled:true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          polylines: Set<Polyline>.of(polylines.values),
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          markers: Set<Marker>.of(markers.values),
          onMapCreated: _onMapCreated

      ),


    ),
  ),
);





  }






}







