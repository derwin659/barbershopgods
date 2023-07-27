

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/chatModel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  @override
  Widget build(BuildContext context) {

    Widget notificationCircle(value){
      return Container(
        child: new Text(value.toString(),style: TextStyle(color: Colors.transparent),),
        height: 20.0,
        width: 20.0,
        decoration: new BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle
        ),
      );


    }

    return ListView.builder(
      itemCount: temporalData.length,
        itemBuilder: (context,index){
        return Column(
          children: [
            new Divider(height: 5.0,),
            new ListTile(
              leading: new CircleAvatar(
                foregroundColor: Colors.cyanAccent,
                backgroundColor: Colors.grey,
                backgroundImage: new NetworkImage(temporalData[index].avatarUrl.toString()),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                new Text(temporalData[index].nombre.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                  new Text(temporalData[index].hora.toString(),style: TextStyle(color: Colors.grey,fontSize: 14.0))
              ]),
              subtitle: new Container(
                padding: const EdgeInsets.only(top: 5.0),
              child: new Row(
                children: [
                  new Text(temporalData[index].mensaje.toString(),style: TextStyle(color: Colors.grey,fontSize: 15.0),),
                  temporalData[index].newMessage.toString() == 0 ? new Container() :
                      notificationCircle(Random().nextInt(5)+1)
                ],
              ),),
            )
          ],
        );
        }
    );


  }
}
