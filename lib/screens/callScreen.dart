

import 'package:flutter/cupertino.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: new Center(child: new Text("Call"),),
    );
  }
}
