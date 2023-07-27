

import 'package:flutter/cupertino.dart';

class StatusScreens extends StatefulWidget {
  const StatusScreens({Key? key}) : super(key: key);

  @override
  State<StatusScreens> createState() => _StatusScreensState();
}

class _StatusScreensState extends State<StatusScreens> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: new Center(child: new Text("Status"),),
    );
  }
}
