

import 'package:flutter/cupertino.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: new Center(child: new Text("Camara"),),
    );
  }
}
