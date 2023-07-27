

import 'package:barberia/screens/callScreen.dart';
import 'package:barberia/screens/cameraScreen.dart';
import 'package:barberia/screens/chatScreen.dart';
import 'package:barberia/screens/statusScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhatsApp extends StatefulWidget {
  const WhatsApp({Key? key}) : super(key: key);

  @override
  State<WhatsApp> createState() => _WhatsAppState();
}

class _WhatsAppState extends State<WhatsApp> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState(){
    super.initState();

    tabController = new TabController(length: 4, vsync: this,initialIndex: 1)..addListener(() {

      if(mounted){
        setState(() {

        });
      }

    });
  }

  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    TabBar tabBar=new TabBar(
      isScrollable: true,
        controller: tabController,
        tabs: [
      new Tab(icon: Icon(Icons.camera_alt),),
      new Tab(text: 'CHATS'),
      new Tab(text: 'ESTADOS'),
      new Tab(text: 'LLAMADAS'),

        ]);
    AppBar appBar=new AppBar(
      title: new Text("WhatsApp"),
      bottom: tabBar,
      actions: [
        Icon(Icons.search),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0),),
        Icon(Icons.more_vert)
      ],
    );

    TabBarView tabBarView = new TabBarView(
      controller: tabController,
        children: [
          new CameraScreen(),
          new ChatScreen(),
          new StatusScreens(),
          new CallScreen()
        ]);

    floatingActionButton(Icon icon){
      return new FloatingActionButton(
        onPressed: (){},
        foregroundColor: Colors.white,
        backgroundColor: Colors.cyanAccent,
      child: icon,);
    }

    Widget floatingActionButtonStatus(Icon iconEdit,Icon iconCamera){
      return new Column(
        children: [
          new FloatingActionButton(
            onPressed: (){},
            foregroundColor: new Color(0xff49646c),
            backgroundColor: new Color(0xffebf4fc),
            child: iconEdit,), SizedBox(height: 10,),
          floatingActionButton(iconCamera)

        ],
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
      );
    }

    //TODO:implement build
    return Scaffold(
      appBar: appBar,
      body: tabBarView,
      floatingActionButton:
      tabController.index==0 ? new Container():
      tabController.index==1 ? floatingActionButton(Icon(Icons.message)):
      tabController.index==2 ? floatingActionButtonStatus(Icon(Icons.edit), Icon(Icons.camera_alt)) :
          floatingActionButton(Icon(Icons.add_call))
    );
  }
}
